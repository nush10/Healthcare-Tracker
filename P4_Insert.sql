use HealthCareManagementSystem
go
INSERT INTO Patient (PatientID, SSN, FirstName, LastName, DateOfBirth, Gender, Email, Address, PhoneNumber, EmergencyContact, BloodType)
VALUES
('PAT001', Convert(Binary(16),'123-45-6789'), 'John', 'Doe', '1990-01-01', 'Male', 'john.doe@email.com', '123 Main St', '555-1234', 'Jane Doe', 'A+'),
('PAT002', Convert(Binary(16),'987-65-4321'), 'Jane', 'Smith', '1985-05-15', 'Female', 'jane.smith@email.com', '456 Oak St', '555-5678', 'John Smith', 'B-'),
('PAT003', Convert(Binary(16),'543-21-9876'), 'Alice', 'Johnson', '1995-08-20', 'Female', 'alice.johnson@email.com', '789 Pine St', '555-8765', 'Bob Johnson', 'O+'),
('PAT004', Convert(Binary(16),'654-32-1098'), 'Michael', 'Williams', '1980-03-10', 'Male', 'michael.williams@email.com', '456 Maple St', '555-4321', 'Laura Williams', 'AB-'),
('PAT005', Convert(Binary(16),'876-54-3210'), 'Emily', 'Brown', '1992-11-05', 'Female', 'emily.brown@email.com', '789 Cedar St', '555-9876', 'Chris Brown', 'A-'),
('PAT006', Convert(Binary(16),'234-56-7890'), 'David', 'Jones', '1988-07-15', 'Male', 'david.jones@email.com', '123 Birch St', '555-2345', 'Sarah Jones', 'B+'),
('PAT007', Convert(Binary(16),'567-89-0123'), 'Sophia', 'Miller', '1975-04-25', 'Female', 'sophia.miller@email.com', '789 Elm St', '555-6789', 'Daniel Miller', 'O-'),
('PAT008', Convert(Binary(16),'789-01-2345'), 'Matthew', 'Davis', '1997-09-30', 'Male', 'matthew.davis@email.com', '456 Oak St', '555-8901', 'Olivia Davis', 'A+'),
('PAT009', Convert(Binary(16),'210-98-7654'), 'Olivia', 'Taylor', '1982-12-12', 'Female', 'olivia.taylor@email.com', '123 Pine St', '555-2109', 'William Taylor', 'AB+'),
('PAT010', Convert(Binary(16),'432-10-9876'), 'Daniel', 'Wilson', '1998-02-18', 'Male', 'daniel.wilson@email.com', '789 Maple St', '555-5432', 'Emma Wilson', 'O-'),
('PAT011', Convert(Binary(16),'876-54-3210'), 'Emma', 'Anderson', '1986-06-22', 'Female', 'emma.anderson@email.com', '456 Cedar St', '555-8765', 'James Anderson', 'B-'),
('PAT012', Convert(Binary(16),'345-67-8901'), 'Christopher', 'Harris', '1993-04-09', 'Male', 'christopher.harris@email.com', '789 Birch St', '555-3456', 'Jessica Harris', 'A+'),
('PAT013', Convert(Binary(16),'987-65-4321'), 'Mia', 'Moore', '1984-10-14', 'Female', 'mia.moore@email.com', '123 Elm St', '555-9876', 'Christopher Moore', 'O-'),
('PAT014', Convert(Binary(16),'123-45-6789'), 'William', 'Clark', '1991-08-07', 'Male', 'william.clark@email.com', '456 Pine St', '555-1234', 'Sophia Clark', 'A-'),
('PAT015', Convert(Binary(16),'567-89-0123'), 'Ava', 'White', '1980-01-30', 'Female', 'ava.white@email.com', '789 Maple St', '555-5678', 'Ethan White', 'AB+'),
('PAT016', Convert(Binary(16),'876-54-3210'), 'Ethan', 'Thomas', '1995-03-28', 'Male', 'ethan.thomas@email.com', '123 Cedar St', '555-8765', 'Lily Thomas', 'B-'),
('PAT017', Convert(Binary(16),'210-98-7654'), 'Lily', 'Brown', '1987-07-05', 'Female', 'lily.brown@email.com', '456 Elm St', '555-2109', 'Noah Brown', 'A+'),
('PAT018', Convert(Binary(16),'432-10-9876'), 'Noah', 'Jones', '1994-09-17', 'Male', 'noah.jones@email.com', '789 Oak St', '555-5432', 'Emily Jones', 'O-'),
('PAT019', Convert(Binary(16),'654-32-1098'), 'Grace', 'Miller', '1983-05-03', 'Female', 'grace.miller@email.com', '123 Birch St', '555-6543', 'Samuel Miller', 'AB-'),
('PAT020', Convert(Binary(16),'876-54-3210'), 'Samuel', 'Roberts', '1996-11-12', 'Male', 'samuel.roberts@email.com', '456 Cedar St', '555-8765', 'Olivia Roberts', 'B+');



INSERT INTO Doctor (DoctorID, LicenseNumber, YearsOfExperience, Education, AvailabilitySchedule, Specialization, DoctorName)
VALUES
    ('DOC001', 12345, 10, 'MD', 'Monday-Friday', 'Cardiology', 'John Smith'),
    ('DOC002', 67890, 8, 'DO', 'Tuesday-Saturday', 'Orthopedics', 'Jane Doe'),
    ('DOC003', 54321, 15, 'MBBS', 'Monday-Wednesday', 'Pediatrics', 'Michael Johnson'),
    ('DOC004', 98765, 12, 'MD', 'Thursday-Sunday', 'Ophthalmology', 'Emily Davis'),
    ('DOC005', 23456, 10, 'MBBS', 'Monday-Friday', 'Dermatology', 'Robert Miller'),
    ('DOC006', 87654, 18, 'DO', 'Wednesday-Saturday', 'Neurology', 'Olivia Wilson'),
    ('DOC007', 34567, 20, 'MD', 'Tuesday-Thursday', 'Cardiothoracic Surgery', 'William Brown'),
    ('DOC008', 76543, 8, 'MBBS', 'Monday-Friday', 'Gastroenterology', 'Sophia Taylor'),
    ('DOC009', 45678, 10, 'DO', 'Monday-Sunday', 'Orthopedics', 'Daniel Anderson'),
    ('DOC010', 65432, 14, 'MD', 'Thursday-Saturday', 'Urology', 'Ava Martinez'),
    ('DOC011', 87654, 12, 'MBBS', 'Tuesday-Sunday', 'Endocrinology', 'Ethan Jackson'),
    ('DOC012', 23456, 15, 'DO', 'Monday-Wednesday', 'Ophthalmology', 'Isabella White'),
    ('DOC013', 56789, 10, 'MD', 'Friday-Sunday', 'Pulmonology', 'Christopher Harris'),
    ('DOC014', 34567, 8, 'MBBS', 'Monday-Thursday', 'Rheumatology', 'Amelia Nelson'),
    ('DOC015', 78901, 10, 'MD', 'Monday-Wednesday', 'Cardiology', 'Matthew Garcia'),
    ('DOC016', 43210, 12, 'DO', 'Thursday-Saturday', 'Nephrology', 'Emma Smith'),
    ('DOC017', 89012, 15, 'MD', 'Monday-Sunday', 'Dermatology', 'Andrew Johnson'),
    ('DOC018', 54321, 8, 'MBBS', 'Wednesday-Friday', 'Neurology', 'Sophie Clark'),
    ('DOC019', 21098, 10, 'DO', 'Tuesday-Sunday', 'Oncology', 'Nathan Baker'),
    ('DOC020', 90123, 14, 'MD', 'Monday-Thursday', 'Gynecology', 'Grace Turner')


INSERT INTO Visit (VisitID, VisitDate, Purpose, Status, DoctorID, PatientID)
VALUES
('VIS001', '2023-01-05 10:00:00', 'Heart Checkup', 'Completed', 'DOC001', 'PAT001'),
('VIS002', '2023-02-10 14:30:00', 'Severe Knee Joint Pain', 'Scheduled', 'DOC002', 'PAT002'),
('VIS003', '2023-03-15 11:15:00', 'Fever', 'Completed', 'DOC003', 'PAT003'),
('VIS004', '2023-04-20 09:45:00', 'Blurry Eye check up', 'Scheduled', 'DOC004', 'PAT004'),
('VIS005', '2023-05-25 13:30:00', 'Skin rashes', 'Completed', 'DOC005', 'PAT005'),
('VIS006', '2023-06-30 15:00:00', 'Seizure', 'Scheduled', 'DOC006', 'PAT006'),
('VIS007', '2023-07-05 08:45:00', 'General Heart Checkup', 'Completed', 'DOC007', 'PAT007'),
('VIS008', '2023-08-10 12:15:00', 'Heavy Stomach Pain', 'Scheduled', 'DOC008', 'PAT008'),
('VIS009', '2023-09-15 14:30:00', 'Orthopedic Consultation', 'Completed', 'DOC009', 'PAT009'),
('VIS010', '2023-10-20 10:30:00', 'Urine Tract Checkup', 'Scheduled', 'DOC010', 'PAT010'),
('VIS011', '2023-11-25 09:00:00', 'Endocrine Assessment', 'Completed', 'DOC011', 'PAT011'),
('VIS012', '2023-12-30 11:45:00', 'Eye care Follow-up', 'Scheduled', 'DOC012', 'PAT012'),
('VIS013', '2024-01-04 13:15:00', 'Pulmonology Consultation', 'Completed', 'DOC013', 'PAT013'),
('VIS014', '2024-02-09 16:00:00', 'Rheumatology Checkup', 'Scheduled', 'DOC014', 'PAT014'),
('VIS015', '2024-03-15 10:45:00', 'Heart Check up', 'Completed', 'DOC015', 'PAT015'),
('VIS016', '2024-04-20 14:30:00', 'Kidney function assessment', 'Scheduled', 'DOC016', 'PAT016'),
('VIS017', '2024-05-25 09:30:00', 'Rosacea condition evaluation', 'Completed', 'DOC017', 'PAT017'),
('VIS018', '2024-06-30 11:15:00', 'Memory loss checkup', 'Scheduled', 'DOC018', 'PAT018'),
('VIS019', '2024-07-05 13:45:00', 'Cancer Chemotherapy', 'Completed', 'DOC019', 'PAT019'),
('VIS020', '2024-08-10 15:30:00', 'Pregancy Checkup', 'Scheduled', 'DOC020', 'PAT020');


INSERT INTO Treatment (TreatmentID, TreatmentName, TreatmentFees, VisitID, Admit_Flag,Notes)
VALUES
('TRT001', 'Cardiac Angiography', 500.00, 'VIS001', 'N',''),
('TRT002', 'Knee Joint Operation', 400.00, 'VIS002', 'Y','Room is Available, Can be admitted'),
('TRT003', 'Antibiotics for Fever', 50.00, 'VIS003', 'N',''),
('TRT004', 'Eye Prescription Glasses', 300.00, 'VIS004', 'N',''),
('TRT005', 'Topical Cream for Skin Rashes', 20.00, 'VIS005', 'N',''),
('TRT006', 'Anti-seizure Medication', 150.00, 'VIS006', 'N',''),
('TRT007', 'Cardiac Stress Test', 200.00, 'VIS007', 'N',''),
('TRT008', 'Gastrointestinal Endoscopy', 500.00, 'VIS008', 'Y','Room is Available, Can be admitted'),
('TRT009', 'Orthopedic Physical Therapy', 400.00, 'VIS009', 'Y','Room is Available, Can be admitted'),
('TRT010', 'Urological Tests', 80.00, 'VIS010', 'N',''),
('TRT011', 'Hormone Replacement Therapy', 600.00, 'VIS011', 'N',''),
('TRT012', 'Eye Care Follow-up Consultation', 50.00, 'VIS012', 'N',''),
('TRT013', 'Pulmonary Function Tests', 300.00, 'VIS013', 'N',''),
('TRT014', 'Rheumatoid Arthritis Medication', 200.00, 'VIS014', 'N',''),
('TRT015', 'Cardiac Medication', 100.00, 'VIS015', 'N',''),
('TRT016', 'Nephrology Consultation', 50.00, 'VIS016', 'N',''),
('TRT017', 'Dermatology Cream for Rosacea', 25.00, 'VIS017', 'N',''),
('TRT018', 'Neurological Memory Tests', 150.00, 'VIS018', 'N',''),
('TRT019', 'Chemotherapy Session', 500.00, 'VIS019', 'Y','Room is Available, Can be admitted'),
('TRT020', 'Obstetric Ultrasound', 150.00, 'VIS020', 'N','');

INSERT INTO Prescription (PrescriptionID, MedicineName, TreatmentID, PrescriptionDate, Dosage)
VALUES
    ('PRE001', 'Aspirin', 'TRT001', Getdate(), 'once every 3 months'),
    ('PRE001', 'Lisinopril', 'TRT001', Getdate(), '2 times daily for 10 days'),
    ('PRE002', 'Advil', 'TRT002', Getdate(), 'Thrice every day for 3 months'),
    ('PRE002', 'Motrin', 'TRT002', Getdate(), 'twice per month'),
    ('PRE003', 'Crocin', 'TRT003', Getdate(), '4 times every week'),
    ('PRE004', 'Eye Drops', 'TRT004', Getdate(), 'once daily for 2 weeks'),
    ('PRE005', 'Azelic Acid Cream', 'TRT005', Getdate(), 'thrice for 5 weeks'),
    ('PRE006', 'Dilantin', 'TRT006', Getdate(), '2 times a daily for 3 months'),
    ('PRE007', 'Atenolol', 'TRT007', Getdate(), '3 times a day for 3 weeks'),
    ('PRE007', 'Carvetilol', 'TRT007', Getdate(), 'once daily for 3months'),
    ('PRE008', 'Lomeramide', 'TRT008', Getdate(), 'Twice a day for 4 days'),
    ('PRE009', 'Moov', 'TRT009', Getdate(), 'Daily for a week'),
    ('PRE010', 'Nitrofuraentoin', 'TRT010', Getdate(), '3 times a day'),
    ('PRE011', 'Hormone Replacement Drug', 'TRT011', Getdate(), 'twice a day for 5 days '),
    ('PRE012', 'Eye Drops', 'TRT012', Getdate(), 'thrice a day for 3 days'),
    ('PRE013', 'Bronchodilator', 'TRT013', Getdate(), 'twice daily for 2 months'),
    ('PRE013', 'Nilgiri', 'TRT013', Getdate(), 'thrice daily for 2 months'),
    ('PRE014', 'Methotrexate', 'TRT014', Getdate(), 'thrice daily for 1 month'),
    ('PRE015', 'Cardiac Medication', 'TRT015', Getdate(), '3 times a day for 3 months'),
    ('PRE016', 'Diuretic', 'TRT016', Getdate(), '2 times daily for 1 week'),
    ('PRE017', 'Topical Cream', 'TRT017', Getdate(), 'twice daily for 3 months'),
    ('PRE018', 'Ritalin', 'TRT018', Getdate(), 'once daily for 1 month'),
    ('PRE019', 'Chemotherapy Drugs', 'TRT019', Getdate(), 'As directed by the physician during admission'),
    ('PRE020', 'Omega3 Vitamins', 'TRT020', Getdate(), 'Once daily for 1 month'),
  ('PRE020', 'Estrace', 'TRT020', Getdate(), 'Once daily for 1 month'),
   ('PRE020', 'Azithromycin', 'TRT020', Getdate(), 'Once daily for 1 month');


INSERT INTO Room (RoomID, RoomType, RoomStatus, RoomCharge)
VALUES
('Room001', 'ICU', 'Available', 500.00),
('Room002', 'General Ward', 'Occupied', 200.00),
('Room003', 'Suite', 'Available', 800.00),
('Room004', 'Operating Room', 'Maintenance', 1000.00),
('Room005', 'ICU', 'Occupied', 550.00),
('Room006', 'General Ward', 'Available', 250.00),
('Room007', 'Suite', 'Occupied', 900.00),
('Room008', 'Operating Room', 'Maintenance', 1100.00),
('Room009', 'ICU', 'Available', 520.00),
('Room010', 'General Ward', 'Occupied', 210.00),
('Room011', 'Suite', 'Available', 850.00),
('Room012', 'Operating Room', 'Maintenance', 1050.00),
('Room013', 'ICU', 'Occupied', 530.00),
('Room014', 'General Ward', 'Available', 220.00),
('Room015', 'Suite', 'Occupied', 920.00),
('Room016', 'Operating Room', 'Maintenance', 1150.00),
('Room017', 'ICU', 'Available', 510.00),
('Room018', 'General Ward', 'Occupied', 230.00),
('Room019', 'Suite', 'Available', 880.00),
('Room020', 'Operating Room', 'Maintenance', 1020.00);


INSERT INTO InsuranceProvider (ProviderID, Name, Address, PhoneNumber, ContactEmail, Website)
VALUES
('PRO01', 'HealthGuard Insurance', '123 Insurance Ave', '800-123-4567', 'info@healthguard.com', 'www.healthguard.com'),
('PRO02', 'SecureCare Insurance', '456 Coverage St', '800-987-6543', 'info@securecare.com', 'www.securecare.com'),
('PRO03', 'QuickHealth Insurance', '789 Coverage Blvd', '800-567-8901', 'info@quickhealth.com', 'www.quickhealth.com'),
('PRO04', 'LifeInsure Health', '101 Policy Lane', '800-234-5678', 'info@lifeinsure.com', 'www.lifeinsure.com'),
('PRO05', 'SafeHealth Assurance', '202 Security St', '800-345-6789', 'info@safehealth.com', 'www.safehealth.com'),
('PRO06', 'NewProvider Insurance', '789 NewCoverage Blvd', '800-111-2222', 'info@newprovider.com', 'www.newprovider.com'),
('PRO07', 'AnotherProvider Insurance', '456 AnotherCoverage St', '800-333-4444', 'info@anotherprovider.com', 'www.anotherprovider.com'),
('PRO08', 'LastProvider Insurance', '123 LastCoverage Ave', '800-555-6666', 'info@lastprovider.com', 'www.lastprovider.com');

INSERT INTO CoveragePlan (PlanID, PlanName, CoverageDetails, Premium, Deductible, CoverageStartDate, CoverageEndDate, ProviderID)
VALUES
('PLA01', 'Basic Plan', 'Basic coverage for common medical services', '60.00', '550.00', '2025-02-01', '2023-12-31', 'PRO01'),
('PLA02', 'Premium Plan', 'Comprehensive coverage including specialist visits', '120.00', '200.00', '2025-03-01', '2023-12-31', 'PRO02'),
('PLA03', 'QuickHealth Standard', 'Standard coverage for medical needs', '80.00', '400.00', '2025-04-01', '2023-12-31', 'PRO03'),
('PLA04', 'LifeInsure Comprehensive', 'Extensive coverage for health and wellness', '140.00', '180.00', '2025-05-01', '2023-12-31', 'PRO04'),
('PLA05', 'SafeHealth Plus', 'Enhanced coverage for preventive care', '100.00', '250.00', '2025-06-01', '2023-12-31', 'PRO05'),
('PLA06', 'Guardian Gold Plan', 'Gold-level coverage for comprehensive health needs', '120.00', '200.00', '2025-07-01', '2023-12-31', 'PRO01'),
('PLA07', 'EverWell Assurance', 'Assurance plan for health and well-being', '105.00', '300.00', '2025-08-01', '2023-12-31', 'PRO02'),
('PLA08', 'FamilyCare Family Plan', 'Family-focused coverage for healthcare needs', '150.00', '180.00', '2025-09-01', '2023-12-31', 'PRO03'),
('PLA09', 'PremierHealth Executive', 'Executive-level coverage for comprehensive healthcare', '170.00', '150.00', '2025-10-01', '2023-12-31', 'PRO04'),
('PLA10', 'EliteCare Platinum', 'Platinum-level coverage for elite health services', '200.00', '100.00', '2025-11-01', '2023-12-31', 'PRO05'),
('PLA11', 'OptimaHealth Elite', 'Elite coverage for advanced medical needs', '145.00', '170.00', '2025-05-15', '2023-12-31', 'PRO06'),
('PLA12', 'TotalCare Premium', 'Premium coverage including wellness programs', '110.00', '220.00', '2025-06-10', '2023-12-31', 'PRO07'),
('PLA13', 'MediSecure Plus', 'Extended coverage for specialized medical services', '75.00', '500.00', '2025-02-10', '2023-12-31', 'PRO08');

 INSERT INTO PatientCoveragePlan
 VALUES
('PAT002',    'PLA05'),
('PAT003',    'PLA05'),
('PAT004',    'PLA04'),
('PAT005',    'PLA07'),
('PAT006',    'PLA07'),
('PAT007',    'PLA07'),
('PAT008',    'PLA07'),
('PAT018',    'PLA09'),
('PAT019',    'PLA09'),
('PAT020',    'PLA09')

-- sp
go
Exec InsertAdmissionFromTreatment


go
Exec InsertBillingData


go
exec InsertPaymentData

go
exec inserttreatmenthistory

go




