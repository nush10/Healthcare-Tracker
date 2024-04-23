create  database HealthCareManagementSystem
go
use  HealthCareManagementSystem
go

CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'u$Vp2#9XqF!z';
go 
CREATE CERTIFICATE PatientSSNCertificate
WITH SUBJECT = 'Patient SSN Encryption';

-- Create a symmetric key for SSN encryption
CREATE SYMMETRIC KEY PatientSSNSymmetricKey
WITH ALGORITHM = AES_256
ENCRYPTION BY CERTIFICATE PatientSSNCertificate;


CREATE TABLE Patient (
    PatientID VARCHAR(50) PRIMARY KEY,
    SSN VARBINARY(MAX),
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
    Gender VARCHAR(10) CHECK (Gender IN ('Other', 'Female', 'Male')),
    Email VARCHAR(100),
    Address VARCHAR(255),
    PhoneNumber VARCHAR(20),
    EmergencyContact VARCHAR(50),
    BloodType VARCHAR(10) CHECK (BloodType IN ('O-', 'O+', 'AB-', 'AB+', 'B-', 'B+', 'A-', 'A+'))
);

OPEN SYMMETRIC KEY PatientSSNSymmetricKey
DECRYPTION BY CERTIFICATE PatientSSNCertificate;

UPDATE Patient
SET 
    SSN = EncryptByKey(Key_GUID('PatientSSNSymmetricKey'), SSN);
GO

CLOSE SYMMETRIC KEY PatientSSNSymmetricKey;
GO

CREATE TABLE Doctor (
    DoctorID VARCHAR(50) PRIMARY KEY,
    DoctorName Nvarchar(100),
    LicenseNumber VARCHAR(20),
    YearsOfExperience INT,
    Education VARCHAR(100),
    AvailabilitySchedule VARCHAR(100),
    Specialization VARCHAR(50)
);

CREATE TABLE Visit (
    VisitID VARCHAR(50) PRIMARY KEY,
    VisitDate DATETIME,
    Purpose VARCHAR(255),
    Status VARCHAR(20) CHECK (Status IN ('Cancelled', 'Completed', 'Scheduled')),
    DoctorID VARCHAR(50) FOREIGN KEY REFERENCES Doctor(DoctorID),
    PatientID VARCHAR(50) FOREIGN KEY REFERENCES Patient(PatientID)
);

CREATE TABLE Treatment (
    TreatmentID VARCHAR(50) PRIMARY KEY,
    TreatmentName VARCHAR(255),
    TreatmentFees DECIMAL(10, 2),
    VisitID VARCHAR(50) FOREIGN KEY REFERENCES Visit(VisitID),
    Admit_Flag CHAR(1) CHECK (Admit_Flag IN ('N', 'Y')),
    Notes Nvarchar(100)
);


CREATE TABLE Prescription (
    PrescriptionID VARCHAR(50) NOT NULL,
    MedicineName VARCHAR(50) NOT NULL,
    TreatmentID VARCHAR(50) NULL,
    PrescriptionDate DATETIME NULL,
    Dosage VARCHAR(255) NULL,
    PRIMARY KEY CLUSTERED (PrescriptionID ASC, MedicineName ASC),
    FOREIGN KEY (TreatmentID) REFERENCES Treatment(TreatmentID)
);

CREATE TABLE Room (
    RoomID VARCHAR(50) NOT NULL PRIMARY KEY,
    RoomType VARCHAR(20) NULL CHECK (RoomType IN ('Operating Room', 'Suite', 'General Ward', 'ICU')),
    RoomStatus VARCHAR(20) NULL CHECK (RoomStatus IN ('Maintenance', 'Available', 'Occupied')),
    RoomCharge DECIMAL(10, 2) NULL
);

CREATE TABLE Admission (
    AdmissionID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    TreatmentID VARCHAR(50) NULL,
    RoomID VARCHAR(50) NULL,
    AdmissionDate DATETIME NULL,
    DischargeDate DATETIME NULL,
    AdmissionReason VARCHAR(255) NULL,
    Status VARCHAR(20) NULL,
    FOREIGN KEY (RoomID) REFERENCES Room(RoomID),
    FOREIGN KEY (TreatmentID) REFERENCES Treatment(TreatmentID)
);

CREATE TABLE Bill (
    BillID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    BillingAmount DECIMAL(10, 2) NULL,
    DateIssued DATETIME NULL,
    Status VARCHAR(20) NULL,
    VisitID VARCHAR(50) NULL,
    FOREIGN KEY (VisitID) REFERENCES Visit(VisitID)
);




CREATE TABLE InsuranceProvider (
    ProviderID VARCHAR(5) NOT NULL PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Address VARCHAR(255) NULL,
    PhoneNumber VARCHAR(15) NULL,
    ContactEmail VARCHAR(255) NULL,
    Website VARCHAR(255) NULL
);

CREATE TABLE CoveragePlan (
    PlanID VARCHAR(50) NOT NULL PRIMARY KEY,
    PlanName VARCHAR(255) NOT NULL,
    CoverageDetails VARCHAR(255) NULL,
    Premium DECIMAL(10, 2) NULL,
    Deductible DECIMAL(10, 2) NULL,
    CoverageStartDate DATE NULL,
    CoverageEndDate DATE NULL,
    ProviderID VARCHAR(5) NULL,
    FOREIGN KEY (ProviderID) REFERENCES InsuranceProvider (ProviderID)
);


CREATE TABLE PatientCoveragePlan
(
    PatientID VARCHAR(50),
    PlanID VARCHAR(50),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (PlanID) REFERENCES CoveragePlan(PlanID),
    PRIMARY KEY (PatientID, PlanID)
);

CREATE TABLE TreatmentHistory (
    TreatmentID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    DateAdministered DATETIME NULL,
    TreatmentDescription NVARCHAR(50) NULL,
    VisitID VARCHAR(50) NULL,
    Cost DECIMAL(18, 2) NULL,
    DoctorID VARCHAR(50) NULL,

    PatientID VARCHAR(50) NULL,   
	FOREIGN KEY (DoctorID) REFERENCES Doctor (DoctorID),
    FOREIGN KEY (PatientID) REFERENCES Patient (PatientID),
    FOREIGN KEY (VisitID) REFERENCES Visit (VisitID)
);
go
Create FUNCTION dbo.AmountCoveredByInsurance (
    @BillID INT,
    @PlanID VARCHAR(5)
)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @CoverageAmount DECIMAL(10, 2);
    DECLARE @BillAmount DECIMAL(10, 2);

    -- Retrieve coverage amount based on BillID and PlanID
    SELECT @CoverageAmount = cp.deductible,
           @BillAmount = b.BillingAmount
    FROM Bill b
	inner join visit v on b.VisitID=v.VisitID
    Join  PatientCoveragePlan pcp on pcp.patientid=v.patientid
    JOIN CoveragePlan cp ON pcp.planid=cp.planid
    WHERE b.BillID = @BillID AND cp.PlanID = @PlanID;

    -- Return the minimum of BillAmount and CoverageAmount to handle the case when BillAmount is less
    RETURN CASE WHEN @BillAmount < @CoverageAmount THEN @BillAmount ELSE @CoverageAmount END;
END;

go



CREATE FUNCTION dbo.CalculateAmountToBePaid (
    @BillID INT,
    @PlanID VARCHAR(5)
)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @Deductible DECIMAL(10, 2);
    DECLARE @AmountToBePaid DECIMAL(10, 2);

    -- Retrieve deductible based on PlanID
    SELECT @Deductible = Deductible
    FROM CoveragePlan
    WHERE PlanID = @PlanID;

    -- Retrieve the total amount from the Bill table based on BillID
    SELECT @AmountToBePaid = BillingAmount
    FROM Bill
    WHERE BillID = @BillID;

    -- Calculate the amount to be paid by subtracting the deductible and coverage amount from the total amount
    SET @AmountToBePaid = @AmountToBePaid - ISNULL(dbo.AmountCoveredByInsurance(@BillID, @PlanID),0);

    -- Ensure the result is non-negative (no negative amounts to be paid)
    SET @AmountToBePaid = CASE WHEN @AmountToBePaid < 0 THEN 0 ELSE @AmountToBePaid END;

    RETURN @AmountToBePaid;
END;

go



CREATE FUNCTION dbo.GetTotalTreatmentCostForPatient(@PatientID VARCHAR(50))
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @TotalAmount DECIMAL(10, 2);

    WITH TreatmentData AS (
        SELECT
            t.TreatmentID,
            t.Admit_Flag,
            a.AdmissionDate,
            a.DischargeDate,
            r.RoomCharge,
            t.TreatmentFees
        FROM
            Treatment t
            LEFT JOIN Admission a ON t.TreatmentID = a.TreatmentID
            LEFT JOIN Room r ON a.RoomID = r.RoomID
            LEFT JOIN Visit v ON t.VisitID = v.VisitID
        WHERE
            v.PatientID = @PatientID
    )

    SELECT @TotalAmount = COALESCE(
        SUM(CASE
                WHEN td.Admit_Flag = 'Y' THEN
                    DATEDIFF(DAY, td.AdmissionDate, COALESCE(td.DischargeDate, GETDATE())) * td.RoomCharge +
                    COALESCE(td.TreatmentFees, 0)
                ELSE
                    COALESCE(td.TreatmentFees, 0)
            END),
        0
    )
    FROM TreatmentData td;

    RETURN @TotalAmount;
END;

go
CREATE FUNCTION dbo.GenerateNewPrimaryKey
(
    @PrimaryKey NVARCHAR(50),
    @Prefix NVARCHAR(10)
)
RETURNS NVARCHAR(50)
AS
BEGIN
    DECLARE @NewNumericID INT;
    DECLARE @NewPrimaryKey NVARCHAR(50);

    -- Set the new numeric ID by incrementing the numeric part
    DECLARE @NumericPart NVARCHAR(50) = RIGHT(@PrimaryKey, LEN(@PrimaryKey) - LEN(@Prefix));
    SET @NewNumericID = ISNULL(CAST(@NumericPart AS INT), 0) + 1;

    -- Concatenate the prefix and the new numeric ID to get the new primary key
    SET @NewPrimaryKey = @Prefix + CAST(@NewNumericID AS NVARCHAR);

    RETURN @NewPrimaryKey;
END;


go


CREATE TABLE Payment (
    PaymentID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    BillID INT NULL,
    PlanID VARCHAR(50) NULL,
    TotalAmount DECIMAL(10, 2) NULL,
    PaymentDate DATE NULL,
    AmountCoveredByInsurance AS ([dbo].[AmountCoveredByInsurance](BillID, PlanID)),
    AmountToBePaid AS ([dbo].[CalculateAmountToBePaid](BillID, PlanID)),
    FOREIGN KEY (BillID) REFERENCES Bill(BillID),
    FOREIGN KEY (PlanID) REFERENCES CoveragePlan(PlanID)
);

go
Create PROCEDURE InsertAdmissionFromTreatment
AS
BEGIN
    SET NOCOUNT ON;

    -- Declare variables
    DECLARE @RoomID VARCHAR(50);
    DECLARE @AdmissionDate DATETIME;
    DECLARE @TreatmentID VARCHAR(50);
    DECLARE @AdmissionReason NVARCHAR(255);
    DECLARE @TreatmentCount INT;

    -- Get the count of eligible TreatmentID
    SELECT @TreatmentCount = COUNT(*)
    FROM Treatment
    WHERE Admit_Flag = 'Y'
      AND TreatmentID NOT IN (SELECT TreatmentID FROM Admission);

    -- Loop through eligible treatments
    WHILE @TreatmentCount > 0
    BEGIN
        -- Get the available room
        SELECT TOP 1 @RoomID = RoomID
        FROM Room
        WHERE RoomStatus = 'Available'
        ORDER BY RoomID;
       SET @AdmissionDate = GETDATE();

        -- Get the next eligible TreatmentID
        SELECT TOP 1 @TreatmentID = TreatmentID
        FROM Treatment
        WHERE Admit_Flag = 'Y'
          AND TreatmentID NOT IN (SELECT TreatmentID FROM Admission)
        ORDER BY TreatmentID;

        -- Get the AdmissionReason from TreatmentName
        SELECT @AdmissionReason = TreatmentName
        FROM Treatment
        WHERE TreatmentID = @TreatmentID;
		
        -- Insert into Admission table
      INSERT INTO Admission (TreatmentID, RoomID, AdmissionDate, DischargeDate, AdmissionReason, Status)
        VALUES (
            @TreatmentID,
            @RoomID,
            @AdmissionDate,
            NULL,
            @AdmissionReason,
            'Admitted'  
        );
        -- Update RoomStatus to 'Occupied' for the assigned room
        UPDATE Room
        SET RoomStatus = 'Occupied'
        WHERE RoomID = @RoomID;

        -- Decrement the count
        SET @TreatmentCount = @TreatmentCount - 1;
    END;
END;

go




Create PROCEDURE InsertBillingData
AS
BEGIN
    SET NOCOUNT ON;
	
    DECLARE @BillingAmount DECIMAL(10, 2);
    DECLARE @DateIssued DATETIME = GETDATE();
    DECLARE @Status VARCHAR(20) = 'Pending';
    DECLARE @VisitID VARCHAR(50);
    DECLARE @DateDifference INT;

    -- Create a temporary table to store unique VisitIDs not present in the Bill table
    CREATE TABLE #UniqueVisitIDs (VisitID VARCHAR(50));

    -- Insert unique VisitIDs into the temporary table
    INSERT INTO #UniqueVisitIDs (VisitID)
    SELECT t.visitid
    FROM treatment t
    WHERE   NOT EXISTS (SELECT 1 FROM Bill b WHERE b.VisitID = t.VisitID)
	and t.treatmentid not in (select treatmentid from admission where dischargedate is null)
	--select * from treatment
    -- Iterate through each unique VisitID
    WHILE EXISTS (SELECT TOP 1 1 FROM #UniqueVisitIDs)
    BEGIN
        -- Get the next unique VisitID
        SELECT TOP 1 @VisitID = VisitID FROM #UniqueVisitIDs;

 if exists(Select 1 from treatment t inner join admission a on t.treatmentid=a.treatmentid and t.visitid=@VisitID and a.dischargedate is null)
begin
        continue;
end
		
        -- Calculate billing amount for admitted patients
        SELECT @DateDifference = DATEDIFF(
            DAY, 
            a.AdmissionDate, 
            a.DischargeDate)
        
        FROM Admission a
        WHERE  a.TreatmentID IN (SELECT TreatmentID FROM Treatment WHERE VisitID = @VisitID);

        

		
       SELECT @BillingAmount = (isnull(@DateDifference,0) * isnull(r.RoomCharge,0) + (t.TreatmentFees))
        FROM treatment t
      left join Admission a ON a.TreatmentID = t.TreatmentID
        left JOIN Room r ON a.RoomID = r.RoomID
        WHERE  t.VisitID = @VisitID
		
		
        -- Insert into the Bill table without specifying BillID (assuming it's an identity column)
        INSERT INTO Bill (BillingAmount, DateIssued, Status, VisitID)
        VALUES (
            @BillingAmount,
            @DateIssued,
            @Status,
            @VisitID
        );

        -- Delete the processed VisitID from the temporary table
        DELETE FROM #UniqueVisitIDs WHERE VisitID = @VisitID;
    END;

    -- Drop the temporary table
    DROP TABLE #UniqueVisitIDs;
END;



go


create procedure inserttreatmenthistory
as 
begin
insert into treatmenthistory
select Visitdate,treatmentname,v.visitid,b.billingamount,v.doctorid,v.patientid from visit v
inner join treatment t on v.visitid=t.visitid
inner join bill b on v.visitid=b.visitid
where  v.visitid not in (select visitid from TreatmentHistory)

end


go


Create PROCEDURE InsertPaymentData
AS
BEGIN
    SET NOCOUNT ON;
    -- Insert data into Payment table for records with PlanID
create table #temp
(BillID int, PlanID varchar(50), BillingAmount decimal(10,2), paymentdate datetime)


insert into #temp
SELECT BillID, PlanID, BillingAmount, GETDATE() AS PaymentDate
FROM (
  SELECT
    b.BillID,
    pcp.PlanID,
    b.BillingAmount,
    ROW_NUMBER() OVER (PARTITION BY b.BillID ORDER BY cp.Deductible DESC) AS RowNum
  FROM
    Bill b
    INNER JOIN Visit v ON b.VisitID = v.VisitID
    LEFT JOIN PatientCoveragePlan pcp ON pcp.PatientID = v.PatientID
    LEFT JOIN CoveragePlan cp ON cp.PlanID = pcp.PlanID
  WHERE
    NOT EXISTS (
      SELECT 1
      FROM Payment
      WHERE
         billid = b.billid
       
    )
    AND pcp.PlanID IS NOT NULL
) AS PlanRecords
WHERE RowNum = 1;

	insert into #temp
    SELECT BillID, NULL AS PlanID, BillingAmount, GETDATE() AS PaymentDate
    FROM Bill b 
	inner join visit v on v.visitid=b.VisitID
    WHERE
        BillID NOT IN (SELECT BillID FROM Payment)
        AND PatientID NOT IN (SELECT PatientID FROM PatientCoveragePlan );

		insert into payment
		select t.* from #temp t 
		left join payment p on p.billid=t.billid 
		where p.billid is null 
END;


go




Create PROCEDURE ScheduleVisit
    @PatientID VARCHAR(50),
    @DoctorID VARCHAR(50),
    @VisitDate DATETIME,
    @Purpose VARCHAR(255)
AS
BEGIN
    DECLARE @VisitID VARCHAR(50);

	Declare @MaxID VARCHAR(50);
SELECT @MaxID = MAX(VisitID) FROM Visit;

-- Set the new VisitID by incrementing the numeric part
DECLARE @NewNumericID INT = ISNULL(CAST(SUBSTRING(@MaxID, 4, LEN(@MaxID) - 3) AS INT), 0) + 1;
DECLARE @NewVisitID VARCHAR(50) = 'VIS' + CAST(@NewNumericID AS VARCHAR);

 INSERT INTO Visit (VisitID, PatientID, DoctorID, VisitDate, Purpose, Status)
    VALUES ( @NewVisitID, @PatientID, @DoctorID, @VisitDate, @Purpose, 'Scheduled');


    -- Retrieving the generated VisitID
    SET @VisitID = (SELECT VisitID FROM Visit WHERE PatientID = @PatientID AND DoctorID = @DoctorID AND VisitDate = @VisitDate);

    -- Returning the VisitID for further reference
    SELECT @VisitID AS NewVisitID;
END;

go


CREATE PROCEDURE InsertTreatment    
    @VisitID VARCHAR(50),    
    @Admit_Flag CHAR(1),    
    @TreatmentFees DECIMAL(10,2)    
AS    
BEGIN   
  

    DECLARE @TreatmentID VARCHAR(50);    
    DECLARE @Note NVARCHAR(255) = '';    
    DECLARE @RoomID VARCHAR(50);    
    
    -- Generate a new TreatmentID    
    SELECT @TreatmentID = 'TRT0' + CAST(ISNULL(MAX(CAST(SUBSTRING(TreatmentID, 4, LEN(TreatmentID) - 3) AS INT)), 0) + 1 AS VARCHAR)    
    FROM Treatment;    
  
 select @TreatmentID  
  
    DECLARE @TreatmentName NVARCHAR(50);    
    SELECT @TreatmentName = Purpose FROM Visit WHERE VisitID = @VisitID;    
    SET @TreatmentName = @TreatmentName + ' Treatment';    
 select @TreatmentName  
    -- Check for room availability if Admit_Flag is 'Y'    
    IF @Admit_Flag = 'Y'    
    BEGIN    
        -- Get the available room    
        SELECT TOP 1 @RoomID = RoomID    
        FROM Room    
        WHERE RoomStatus = 'Available'    
        ORDER BY RoomID;    
        -- If a room is available, insert into the Treatment table    
        IF @RoomID IS NULL    
        BEGIN    
			
			SET @Note = 'Room not available.';          
        END   
		ELSE  
		BEGIN  
  
		set @Note='Room is Available, Can be admitted';  
  
		END  
     INSERT INTO Treatment (TreatmentID, TreatmentName, TreatmentFees, VisitID, Admit_Flag, Notes)    
     VALUES (@TreatmentID, @TreatmentName, @TreatmentFees, @VisitID, @Admit_Flag, @Note);    
           
    END    
    ELSE    
    BEGIN    
        -- If Admit_Flag is 'N', simply insert into the Treatment table    
        INSERT INTO Treatment (TreatmentID, TreatmentName, TreatmentFees, VisitID, Admit_Flag,Notes)    
        VALUES (@TreatmentID, @TreatmentName, @TreatmentFees, @VisitID, @Admit_Flag,'');    
   
    END    
    
        
END;  
  



go
CREATE PROCEDURE CheckRoomAvailability
    @VisitID VARCHAR(50)
AS
BEGIN
    -- Get admission information based on the provided VisitID
    DECLARE @RoomCount INT;
    
    SELECT @RoomCount = COUNT(1) 
    FROM Room 
    WHERE RoomStatus = 'Available';

    IF @RoomCount > 0
    BEGIN
        -- Room is available, you can proceed with the admission
        EXEC InsertAdmissionFromTreatment;
        PRINT 'Room is available.Available room is assigned.';
    END
    ELSE
    BEGIN
        THROW 50001, 'Room is not available during the specified period.', 1;
    END
END

go

CREATE VIEW MonthlySummaryView AS
SELECT
    Year,
    Month,
    SUM(InpatientCount) AS TotalInpatient,
    SUM(OutpatientCount) AS TotalOutpatient,
    SUM(TotalAdmissionDays) AS TotalAdmissionDays,
    SUM(TotalRoomCharges) AS TotalRoomCharges,
    SUM(TotalTreatmentFees) AS TotalTreatmentFees,
    SUM(TotalRevenue) AS TotalRevenue
FROM (
      SELECT
        YEAR(Admission.AdmissionDate) AS Year,
        MONTH(Admission.AdmissionDate) AS Month,
        COUNT(1) AS InpatientCount,
        0 AS OutpatientCount,
        SUM(DATEDIFF(DAY, Admission.AdmissionDate, Admission.DischargeDate)) AS TotalAdmissionDays,
        SUM(Room.RoomCharge * DATEDIFF(DAY, Admission.AdmissionDate, Admission.DischargeDate)) AS TotalRoomCharges,
        SUM(Treatment.TreatmentFees) AS TotalTreatmentFees,
        SUM(Room.RoomCharge * DATEDIFF(DAY, Admission.AdmissionDate, Admission.DischargeDate) + Treatment.TreatmentFees) AS TotalRevenue
    FROM
        Admission
    INNER JOIN
        Room ON Admission.RoomID = Room.RoomID
    INNER JOIN
        Treatment ON Admission.TreatmentID = Treatment.TreatmentID
    GROUP BY
        YEAR(Admission.AdmissionDate),
        MONTH(Admission.AdmissionDate)

    UNION

    SELECT
        YEAR(Visit.VisitDate) AS Year,
        MONTH(Visit.VisitDate) AS Month,
        0 AS InpatientCount,
        COUNT(1) AS OutpatientCount,
        0 AS TotalAdmissionDays,
        0 AS TotalRoomCharges,
        SUM(Treatment.TreatmentFees) AS TotalTreatmentFees,
        SUM(Treatment.TreatmentFees) AS TotalRevenue
    FROM
        Visit
    INNER JOIN
        Treatment ON Visit.VisitID = Treatment.VisitID
    GROUP BY
        YEAR(Visit.VisitDate),
        MONTH(Visit.VisitDate)
) AS MonthlyData
GROUP BY
    Year,
    Month
go


CREATE VIEW PatientTreatment AS
SELECT
    v.VisitID,
    v.PatientID,
    p.FirstName+''+p.LastName Patient_Name,
	p.Gender,
    d.DoctorID,
    t.TreatmentName,
    t.TreatmentFees,
    t.Admit_Flag,
    b.BillingAmount,
    c.PlanName AS CoveragePlan,
    py.AmountCoveredByInsurance AS CoverageAmount,
    py.AmountToBePaid
FROM
    Visit v
    JOIN Patient p ON v.PatientID = p.PatientID
    JOIN Doctor d ON v.DoctorID = d.DoctorID
    LEFT JOIN Treatment t ON v.VisitID = t.VisitID
    LEFT JOIN Admission a ON  t.TreatmentID = a.TreatmentID
    LEFT JOIN Bill b ON v.VisitID = b.VisitID
	Left Join PatientCoveragePlan pcp on pcp.PatientID=v.PatientID
    LEFT JOIN CoveragePlan c ON c.planid=pcp.planid
    LEFT JOIN Payment py ON b.BillID = py.BillID


	go
CREATE VIEW PatientPrescriptionTreatmentView
AS
SELECT
    p.PatientID,
    p.FirstName + ' ' + p.LastName AS PatientName,
    d.DoctorID,
    pr.PrescriptionID,
    pr.PrescriptionDate,
    tr.TreatmentName,
    ROW_NUMBER() OVER (ORDER BY pr.PrescriptionID) AS MedicineLine,
    MedicineName
FROM
    Patient p
    JOIN Visit d ON p.PatientID = d.PatientID 
    JOIN Treatment tr ON tr.VisitID = d.VisitID
    JOIN Prescription pr ON tr.TreatmentID = pr.TreatmentID;

	go

CREATE TRIGGER UpdateBillStatus
ON Payment
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Bill
    SET Status = 'Paid'
    FROM Bill b
    INNER JOIN inserted i ON b.BillID = i.BillID;
END;


go

CREATE TRIGGER UpdateBillingOnDischarge
ON Admission
AFTER UPDATE
AS
BEGIN
    -- Check if DischargeDate is updated
    IF UPDATE(DischargeDate)
    BEGIN
        -- Call the InsertBillingData stored procedure

        EXEC InsertBillingData;
    END
END;

go



CREATE NONCLUSTERED INDEX IX_Visit_DoctorID
ON Visit (DoctorID);

CREATE NONCLUSTERED INDEX IX_Visit_PatientID
ON Visit (PatientID);


CREATE NONCLUSTERED INDEX IX_Bill_VisitID
ON Bill (VisitID);

CREATE NONCLUSTERED INDEX IX_Admission_TreatmentID
ON Admission (TreatmentID);



















