# Healthcare Tracker (HIPAA-Compliant Data Architecture)
## Team 8:
- Shrey Patel
- Anushka Paradkar
- Yash Badani
- Raveena Patil 
- Rutuja Patil 

## Phase 1:
**GIT LINK:** [ShreyPatel4/DAMG6210_Group_8: HIPPA Compliant Database](https://github.com/ShreyPatel4/DAMG6210_Group_8)

## Overall:
In the world of healthcare, doctors, patients, and insurers need a system that is both powerful and trustworthy. We're planning to build from the ground up, using PostgreSQL as our foundation. We'll design it to follow important rules, like HIPAA, and ensure it keeps everyone's data safe and accessible. Our approach will involve creating a smart database structure, setting up real-time responses for different user actions, and adding safety features to protect the data. In simple terms, we're building a reliable tech backbone for healthcare.

## Objective:
Design and implement a robust, HIPAA-compliant data architecture for medical applications, rooted in advanced SQL methodologies. At the nucleus of this design is a centralized relational database system (RDBMS), structured with a well-structured and optimized database schema to ensure data integrity and minimize redundancy. To manage dynamic interactions between patients, healthcare providers, and insurers, we'll employ SQL triggers and event-driven programming. Upon specific authentication events, these triggers will instantiate temporary views using complex JOIN operations, pulling data from multiple tables while ensuring data encapsulation. The use of B-tree and bitmap indexes will be pivotal in optimizing SELECT queries and enhancing data retrieval speeds. Stored procedures, fortified with parameterized queries, will encapsulate business logic, ensuring data operations are both secure and efficient. User-defined functions (UDFs) will be crafted to handle repetitive tasks, like data validation or transformation, ensuring a modular approach to data operations. To safeguard data integrity during operations, transaction control mechanisms will be stringently applied, ensuring each operation adheres to the ACID properties.

## Deliverables:
**Statement of the Chosen Topic:** A document detailing the choice to develop a robust, HIPAA-compliant data architecture using advanced SQL methodologies.

### Mission Statement and Mission Objectives Document:
- **Mission Statement:** To design and implement a state-of-the-art, HIPAA-compliant data architecture for medical applications, ensuring secure, efficient, and real-time data interactions.
- **Mission Objectives:**
  - Craft a well-structured and optimized database schema to ensure data integrity and minimize redundancy.
  - Utilize SQL triggers for dynamic data interactions based on authentication events.
  - Optimize data retrieval using advanced SQL techniques like B-tree and bitmap indexes.
  - Implement stored procedures and UDFs for modular and secure data operations.
  - Ensure all data operations uphold the ACID properties.
  - Maintain full compliance with HIPAA standards throughout the design and implementation.

**Acknowledgment of Learning Curve:** This project acknowledges the need to familiarize and master advanced SQL concepts, like B-tree indexing. While there's a learning curve involved, the team is committed to undertaking this learning and ensuring as much compliance to these advanced techniques as possible.

## Outcome:
A clear and deep understanding of the project's aim to design a HIPAA-compliant data architecture, the specific technical objectives to be achieved, and the acknowledgment of the learning curve involved.
