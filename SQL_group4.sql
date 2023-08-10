/********************************************
MILESTONE 3 - GROUP 4 - 
-----------------------
MY FLUFFY PET
Veterinary clinic
------------------------
Julia Alekseev, 051292134
Ka Ying Chan, 123231227
Prabhjot Singh Longia, 172569212
Harsh Pahurkar, 115587222
-----------------------
2023-08-10
********************************************/


--To be deleted

DROP TABLE xPrescriptionDetails     CASCADE CONSTRAINTS;
DROP TABLE xPrescriptions           CASCADE CONSTRAINTS;
DROP TABLE xMedications             CASCADE CONSTRAINTS;
DROP TABLE xVeterinarians           CASCADE CONSTRAINTS;
DROP TABLE xEmployees               CASCADE CONSTRAINTS;
DROP TABLE xPatients                CASCADE CONSTRAINTS;
DROP TABLE xAppointmentsDetails     CASCADE CONSTRAINTS;
DROP TABLE xAppointments            CASCADE CONSTRAINTS;
DROP TABLE xInvoiceDetails          CASCADE CONSTRAINTS;
DROP TABLE xInvoices                CASCADE CONSTRAINTS;
DROP TABLE xPhones                  CASCADE CONSTRAINTS;
DROP TABLE xPeople                  CASCADE CONSTRAINTS;
DROP TABLE xProcedures              CASCADE CONSTRAINTS;

CREATE TABLE xPeople (
    personId        NUMBER(4)                       PRIMARY KEY,
    lastName        VARCHAR(25)                     NOT NULL,
    firstName       VARCHAR(25)                     NOT NULL,
    dob             DATE                            NOT NULL,
    email           VARCHAR(100), 
    address         VARCHAR(200)                    NOT NULL,
    city            VARCHAR(50)                     NOT NULL,
    prov            CHAR(2)         DEFAULT 'ON'    NOT NULL,
    postalCode      VARCHAR(8)                      NOT NULL
);


CREATE TABLE xPhones (
    phoneNum        VARCHAR2(12),
    personId        NUMBER(4),
    phoneType       VARCHAR2(13),
    PRIMARY KEY (phoneNum, personId),
    FOREIGN KEY (personId) REFERENCES xPeople(personId)
);



CREATE TABLE xPatients (
    patientId       NUMBER(4)       PRIMARY KEY,
    patientName     VARCHAR2(50)    NOT NULL,
    animalType      VARCHAR2(10)    NOT NULL,
    breed           VARCHAR2(50)    NOT NULL,
    dob             DATE            NOT NULL,
    sex             VARCHAR2(2)     NOT NULL,
    isFixed         CHAR(1)         NOT NULL CHECK (isFixed IN ('Y', 'N')),
    isMicrochipped  CHAR(1)         NOT NULL CHECK (isMicrochipped IN ('Y', 'N')),
    microchip       VARCHAR2(20),
    prov            CHAR(2)         DEFAULT 'ON',
    ownerId         NUMBER(4)       NOT NULL,
    CONSTRAINT fk_owner FOREIGN KEY (ownerId) REFERENCES xPeople(personId)
);



CREATE TABLE xEmployees (
    employeeId          NUMBER(4)       PRIMARY KEY,
    sin                 VARCHAR(50)     NOT NULL,
    userName            VARCHAR(15),
    userPassword        VARCHAR(15),
    empPosition         VARCHAR(50)     NOT NULL,
    currentHourlyPay    DECIMAL(5,2)    NOT NULL,
    FOREIGN KEY (employeeId) REFERENCES xPeople(personId)
);


CREATE TABLE xVeterinarians (
    dvmId               NUMBER(4)           PRIMARY KEY,
    dvmLicence          CHAR(10)            NOT NULL,
    FOREIGN KEY (dvmId) REFERENCES xEmployees(employeeId)
);

CREATE TABLE xProcedures (
    procedureId         NUMBER(4)           PRIMARY KEY,
    procedureName       VARCHAR2(50)        NOT NULL,
        employeeId          NUMBER(4)       NOT NULL,      
    currentServiceRate  DECIMAL(8, 2)       NOT NULL,
    FOREIGN KEY (employeeId) REFERENCES xEmployees(employeeId)
);

CREATE TABLE xAppointments (
    appointmentId       NUMBER(4)           PRIMARY KEY,
    apptDateTime        TIMESTAMP,
    patientId           NUMBER(4),
    FOREIGN KEY (patientId) REFERENCES xPatients(patientId)
);

CREATE TABLE xAppointmentsDetails (
    appointmentDateTime     DATE,
    procedureId             NUMBER(4)       NOT NULL,
    reasonForAppointment    VARCHAR(100),
    PRIMARY KEY (appointmentDateTime, procedureId),
    FOREIGN KEY (procedureId) REFERENCES xProcedures(procedureId)
);


CREATE TABLE xMedications (
    medId               NUMBER(5)           PRIMARY KEY,
    medName             VARCHAR(100)        NOT NULL,
    medClass            VARCHAR(50)         NOT NULL,
    medType             VARCHAR(50)         NOT NULL,
    brand               VARCHAR(35)         NOT NULL,
    buyPrice            DECIMAL(5,2)        NOT NULL
);


CREATE TABLE xPrescriptions (
    prescriptionId      NUMBER(5)           PRIMARY KEY,
    appointmentDateTime DATE                NOT NULL,
    patientId           NUMBER(4)           NOT NULL,
    dvmId               NUMBER(4)           NOT NULL,
    FOREIGN KEY (patientId) REFERENCES xPatients(patientId),
    FOREIGN KEY (dvmId)     REFERENCES xVeterinarians(dvmId)
);


CREATE TABLE xPrescriptionDetails (
    prescriptionId      NUMBER(5),
    medId               NUMBER(5),
    notes               VARCHAR(100)        NOT NULL,
    PRIMARY KEY (prescriptionId, medId),
    FOREIGN KEY (prescriptionId)        REFERENCES xPrescriptions(prescriptionId),
    FOREIGN KEY (medId)                 REFERENCES xMedications(medId)
);


CREATE TABLE xInvoices (
    invoiceId           NUMBER(5)           PRIMARY KEY,
    patientId           NUMBER(4)           NOT NULL,
    dateAndTime         DATE                NOT NULL,
    FOREIGN KEY (patientId) REFERENCES xPatients(patientId)
);

CREATE TABLE xInvoiceDetails (
    lineNumber          NUMBER(2),
    invoiceId           NUMBER(5),
    procedureId         NUMBER(4),
    medicationId        NUMBER(5),
    pricePaid           DECIMAL(8, 2)       NOT NULL, 
    PRIMARY KEY (lineNumber, invoiceId),
    FOREIGN KEY (invoiceId)     REFERENCES xInvoices(invoiceId),
    FOREIGN KEY (medicationId)  REFERENCES xMedications(medId)
); 



INSERT ALL 
INTO xPeople (personId, lastName, firstName, dob, email, address, city, prov, postalCode)
VALUES (1001, 'Smith', 'John', '1985-05-10', 'john.smith@google.com', '123 Main St', 'Toronto', 'ON', 'M5V2T6')
INTO xPeople (personId, lastName, firstName, dob, email, address, city, prov, postalCode)
VALUES (1002, 'Doe', 'Jane', '1990-08-15', 'jane.doe@hotmail.com', '456 Oak Ave', 'Ottawa', 'ON', 'K1P 5G4')
INTO xPeople (personId, lastName, firstName, dob, email, address, city, prov, postalCode)
VALUES (1003, 'Johnson', 'Michael', '1978-12-03', 'michael.johnson@google.com', '789 Elm Rd', 'Hamilton', 'ON', 'L8P1H6')
INTO xPeople (personId, lastName, firstName, dob, email, address, city, prov, postalCode)
VALUES (1004, 'Williams', 'Emily', '1989-07-22', 'emily.williams@hotmail.com', '101 Pine Ln', 'London', 'ON', 'N6A1R5')
INTO xPeople (personId, lastName, firstName, dob, email, address, city, prov, postalCode)
VALUES (1005, 'Brown', 'Daniel', '1995-04-17', 'daniel.brown@google.com', '222 Maple Dr', 'Mississauga', 'ON', 'L5B4M7')
INTO xPeople (personId, lastName, firstName, dob, email, address, city, prov, postalCode)
VALUES (1006, 'Miller', 'Sarah', '1982-09-28', 'sarah.miller@hotmail.com', '333 Birch St', 'Brampton', 'ON', 'L6T0E2')
INTO xPeople (personId, lastName, firstName, dob, email, address, city, prov, postalCode)
VALUES (1007, 'Davis', 'William', '1992-02-08', 'william.davis@google.com', '444 Cedar Ave', 'Markham', 'ON', 'L3R8B7')
INTO xPeople (personId, lastName, firstName, dob, email, address, city, prov, postalCode)
VALUES (1008, 'Martinez', 'Olivia', '1987-11-12', 'olivia.martinez@hotmail.com', '555 Willow Rd', 'Vaughan', 'ON', 'L4J7Y6')
INTO xPeople (personId, lastName, firstName, dob, email, address, city, prov, postalCode)
VALUES (1009, 'Rodriguez', 'James', '1976-06-30', 'james.rodriguez@google.com', '666 Oak St', 'Richmond Hill', 'ON', 'L4C0L8')
INTO xPeople (personId, lastName, firstName, dob, email, address, city, prov, postalCode)
VALUES (1010, 'Lee', 'Emma', '1998-03-25', 'emma.lee@hotmail.com', '777 Elm Ave', 'Oakville', 'ON', 'L6H 6P9')
INTO xPeople (personId, lastName, firstName, dob, email, address, city, prov, postalCode)
VALUES (1011, 'Thompson', 'Alexander', '1984-10-19', 'alexander.thompson@google.com', '888 Maple Ln', 'Burlington', 'ON', 'L7R2L8')
INTO xPeople (personId, lastName, firstName, dob, email, address, city, prov, postalCode)
VALUES (1012, 'Scott', 'Mia', '1991-01-06', 'mia.scott@hotmail.com', '999 Pine Rd', 'Oshawa', 'ON', 'L1H7K5')
INTO xPeople (personId, lastName, firstName, dob, email, address, city, prov, postalCode)
VALUES (1013, 'Hall', 'Benjamin', '1980-05-14', 'benjamin.hall@google.com', '111 Birch Dr', 'Whitby', 'ON', 'L1N8X1')
INTO xPeople (personId, lastName, firstName, dob, email, address, city, prov, postalCode)
VALUES (1014, 'Young', 'Amelia', '1986-08-09', 'amelia.young@hotmail.com', '222 Oak St', 'Ajax', 'ON', 'L1S2V8')
INTO xPeople (personId, lastName, firstName, dob, email, address, city, prov, postalCode)
VALUES (1015, 'Lopez', 'Ethan', '1997-07-11', 'ethan.lopez@google.com', '333 Maple Ave', 'Pickering', 'ON', 'L1W3T7')
INTO xPeople (personId, lastName, firstName, dob, email, address, city, prov, postalCode)
VALUES (1016, 'Adams', 'Sofia', '1979-09-29', 'sofia.adams@hotmail.com', '444 Elm Rd', 'Milton', 'ON', 'L9T3N5')
INTO xPeople (personId, lastName, firstName, dob, email, address, city, prov, postalCode)
VALUES (1017, 'Lewis', 'Matthew', '1993-02-14', 'matthew.lewis@google.com', '555 Cedar St', 'Newmarket', 'ON', 'L3Y1R6')
INTO xPeople (personId, lastName, firstName, dob, email, address, city, prov, postalCode)
VALUES (1018, 'King', 'Ava', '1988-12-02', 'ava.king@hotmail.com', '666 Willow Ave', 'Aurora', 'ON', 'L4G3L8')
INTO xPeople (personId, lastName, firstName, dob, email, address, city, prov, postalCode)
VALUES (1019, 'Powell', 'Alexander', '1977-06-25', 'alexander.powell@google.com', '777 Birch Dr', 'Ajax', 'ON', 'L1S2V8')
INTO xPeople (personId, lastName, firstName, dob, email, address, city, prov, postalCode)
VALUES (1020, 'Turner', 'Charlotte', '1994-03-18', 'charlotte.turner@hotmail.com', '888 Oak St', 'Markham', 'ON', 'L3R8B7')
SELECT * FROM dual;




INSERT ALL
INTO xPhones (phoneNum, personId, phoneType) VALUES ('111-111-1111', 1001, 'Home')
INTO xPhones (phoneNum, personId, phoneType) VALUES ('222-222-2222', 1002, 'Mobile')
INTO xPhones (phoneNum, personId, phoneType) VALUES ('333-333-3333', 1003, 'Home')
INTO xPhones (phoneNum, personId, phoneType) VALUES ('444-444-4444', 1004, 'Mobile')
INTO xPhones (phoneNum, personId, phoneType) VALUES ('555-555-5555', 1005, 'Mobile')
INTO xPhones (phoneNum, personId, phoneType) VALUES ('666-666-6666', 1006, 'Home')
INTO xPhones (phoneNum, personId, phoneType) VALUES ('777-777-7777', 1007, 'Home')
INTO xPhones (phoneNum, personId, phoneType) VALUES ('888-888-8888', 1008, 'Mobile')
INTO xPhones (phoneNum, personId, phoneType) VALUES ('999-999-9999', 1009, 'Mobile')
INTO xPhones (phoneNum, personId, phoneType) VALUES ('101-010-1010', 1010, 'Mobile')
INTO xPhones (phoneNum, personId, phoneType) VALUES ('202-020-2020', 1011, 'Home')
INTO xPhones (phoneNum, personId, phoneType) VALUES ('303-030-3030', 1012, 'Home')
INTO xPhones (phoneNum, personId, phoneType) VALUES ('404-040-4040', 1013, 'Mobile')
INTO xPhones (phoneNum, personId, phoneType) VALUES ('505-050-5050', 1014, 'Home')
INTO xPhones (phoneNum, personId, phoneType) VALUES ('606-060-6060', 1015, 'Mobile')
INTO xPhones (phoneNum, personId, phoneType) VALUES ('707-070-7070', 1016, 'Mobile')
INTO xPhones (phoneNum, personId, phoneType) VALUES ('808-080-8080', 1017, 'Home')
INTO xPhones (phoneNum, personId, phoneType) VALUES ('909-090-9090', 1018, 'Mobile')
INTO xPhones (phoneNum, personId, phoneType) VALUES ('123-456-7890', 1019, 'Home')
INTO xPhones (phoneNum, personId, phoneType) VALUES ('987-654-3210', 1020, 'Mobile')
SELECT * FROM dual;

INSERT ALL 
    INTO xPatients (patientId, patientName, animalType, breed, dob, sex, isFixed, isMicrochipped, microchip, ownerId)
    VALUES (2001, 'Max', 'Dog', 'Golden Retriever', TO_DATE('2019-03-15', 'YYYY-MM-DD'), 'M', 'Y', 'N', 'N/A', 1001)
    INTO xPatients (patientId, patientName, animalType, breed, dob, sex, isFixed, isMicrochipped, microchip, ownerId)
    VALUES (2002, 'Bella', 'Cat', 'Siamese', TO_DATE('2020-05-10', 'YYYY-MM-DD'), 'F', 'N', 'Y', 'DEF456', 1002)
    INTO xPatients (patientId, patientName, animalType, breed, dob, sex, isFixed, isMicrochipped, microchip, ownerId)
    VALUES (2003, 'Rocky', 'Dog', 'German Shepherd', TO_DATE('2018-12-20', 'YYYY-MM-DD'), 'M', 'Y', 'Y', 'GHI789', 1003)
    INTO xPatients (patientId, patientName, animalType, breed, dob, sex, isFixed, isMicrochipped, microchip, ownerId)
    VALUES (2004, 'Luna', 'Cat', 'Persian', TO_DATE('2019-08-05', 'YYYY-MM-DD'), 'F', 'N', 'N', 'N/A', 1004)
    INTO xPatients (patientId, patientName, animalType, breed, dob, sex, isFixed, isMicrochipped, microchip, ownerId)
    VALUES (2005, 'Cooper', 'Dog', 'Labrador Retriever', TO_DATE('2020-01-25', 'YYYY-MM-DD'), 'M', 'Y', 'Y', 'MNO345', 1005)
    INTO xPatients (patientId, patientName, animalType, breed, dob, sex, isFixed, isMicrochipped, microchip, ownerId)
    VALUES (2006, 'Simba', 'Cat', 'Maine Coon', TO_DATE('2017-06-12', 'YYYY-MM-DD'), 'M', 'Y', 'N', 'N/A', 1006)  
    INTO xPatients (patientId, patientName, animalType, breed, dob, sex, isFixed, isMicrochipped, microchip, ownerId)
    VALUES (2007, 'Daisy', 'Dog', 'Poodle', TO_DATE('2019-09-30', 'YYYY-MM-DD'), 'F', 'Y', 'Y', 'STU901', 1007)  
    INTO xPatients (patientId, patientName, animalType, breed, dob, sex, isFixed, isMicrochipped, microchip, ownerId)
    VALUES (2008, 'Whiskers', 'Cat', 'British Shorthair', TO_DATE('2020-11-08', 'YYYY-MM-DD'), 'M', 'Y', 'Y', 'VWX234', 1008)   
    INTO xPatients (patientId, patientName, animalType, breed, dob, sex, isFixed, isMicrochipped, microchip, ownerId)
    VALUES (2009, 'Buddy', 'Dog', 'Bulldog', TO_DATE('2016-07-17', 'YYYY-MM-DD'), 'M', 'N', 'Y', 'YZA567', 1009)  
    INTO xPatients (patientId, patientName, animalType, breed, dob, sex, isFixed, isMicrochipped, microchip, ownerId)
    VALUES (2010, 'Nala', 'Cat', 'Ragdoll', TO_DATE('2021-02-12', 'YYYY-MM-DD'), 'F', 'Y', 'N', 'N/A', 1010)  
    INTO xPatients (patientId, patientName, animalType, breed, dob, sex, isFixed, isMicrochipped, microchip, ownerId)
    VALUES (2011, 'Rocky', 'Dog', 'Boxer', TO_DATE('2018-10-03', 'YYYY-MM-DD'), 'M', 'Y', 'Y', 'CDE901', 1011) 
    INTO xPatients (patientId, patientName, animalType, breed, dob, sex, isFixed, isMicrochipped, microchip, ownerId)
    VALUES (2012, 'Oliver', 'Cat', 'Sphynx', TO_DATE('2019-04-28', 'YYYY-MM-DD'), 'M', 'Y', 'N', 'N/A', 1012) 
    INTO xPatients (patientId, patientName, animalType, breed, dob, sex, isFixed, isMicrochipped, microchip, ownerId)
    VALUES (2013, 'Charlie', 'Dog', 'Beagle', TO_DATE('2020-06-15', 'YYYY-MM-DD'), 'M', 'N', 'Y', 'HIJ456', 1013)  
    INTO xPatients (patientId, patientName, animalType, breed, dob, sex, isFixed, isMicrochipped, microchip, ownerId)
    VALUES (2014, 'Luna', 'Cat', 'Scottish Fold', TO_DATE('2019-11-20', 'YYYY-MM-DD'), 'F', 'Y', 'Y', 'KLM789', 1014)   
    INTO xPatients (patientId, patientName, animalType, breed, dob, sex, isFixed, isMicrochipped, microchip, ownerId)
    VALUES (2015, 'Bella', 'Dog', 'Shih Tzu', TO_DATE('2017-12-05', 'YYYY-MM-DD'), 'F', 'N', 'N', 'N/A', 1015)
SELECT * FROM dual;


INSERT ALL
INTO xEmployees (employeeId, sin, userName, userPassword, empPosition, currentHourlyPay)
VALUES (1016, '123456789', 'vet_john', 'vet@j2023', 'Vet', 50.00)
INTO xEmployees (employeeId, sin, userName, userPassword, empPosition, currentHourlyPay)
VALUES (1017, '987654321', 'groomer_jane', 'groom@j23', 'Groomer', 25.00)
INTO xEmployees (employeeId, sin, userName, userPassword, empPosition, currentHourlyPay)
VALUES (1018, '456789123', 'recept_mary', 'recpt@m23', 'Receptionist', 20.00)
INTO xEmployees (employeeId, sin, userName, userPassword, empPosition, currentHourlyPay)
VALUES (1019, '789123456', 'tech_mich', 'tech@m23', 'Vet Technician', 30.00)
INTO xEmployees (employeeId, sin, userName, userPassword, empPosition, currentHourlyPay)
VALUES (1020, '654321789', 'tech_sarah', 'tech@s23', 'Vet Technician', 30.00)
INTO xEmployees (employeeId, sin, userName, userPassword, empPosition, currentHourlyPay)
VALUES (1011, '321789654', 'tech_david', 'tech@d23', 'Vet Technician', 30.00)
SELECT * FROM dual;



INSERT INTO xVeterinarians (dvmId, dvmLicence)
VALUES (1016, 'LIC-VET-01');


INSERT ALL
    INTO xMedications (medId, medName, medClass, medType, brand, buyPrice)
    VALUES (2001, 'Rimadyl', 'Non-Steroidal Anti-Inflammatory Drug (NSAID)', 'Tablet', 'Zoetis', 15.50)
    INTO xMedications (medId, medName, medClass, medType, brand, buyPrice)
    VALUES (2002, 'Apoquel', 'Anti-Pruritic (Anti-Itch)', 'Tablet', 'Zoetis', 25.75)
    INTO xMedications (medId, medName, medClass, medType, brand, buyPrice)
    VALUES (2003, 'Revolution', 'Antiparasitic', 'Topical', 'Zoetis', 19.99)
    INTO xMedications (medId, medName, medClass, medType, brand, buyPrice)
    VALUES (2004, 'Tramadol', 'Opioid Pain Reliever', 'Tablet', 'Amneal', 10.20)
    INTO xMedications (medId, medName, medClass, medType, brand, buyPrice)
    VALUES (2005, 'Acepromazine', 'Sedative', 'Tablet', 'PromAce', 12.30)
    INTO xMedications (medId, medName, medClass, medType, brand, buyPrice)
    VALUES (2006, 'Baytril', 'Antibiotic', 'Tablet', 'Bayer', 9.99)
    INTO xMedications (medId, medName, medClass, medType, brand, buyPrice)
    VALUES (2007, 'Prednisone', 'Steroid', 'Tablet', 'Deltasone', 8.80)
    INTO xMedications (medId, medName, medClass, medType, brand, buyPrice)
    VALUES (2008, 'Frontline Plus', 'Antiparasitic', 'Topical', 'Merial', 22.95)
    INTO xMedications (medId, medName, medClass, medType, brand, buyPrice)
    VALUES (2009, 'Meloxicam', 'Non-Steroidal Anti-Inflammatory Drug (NSAID)', 'Tablet', 'Metacam', 13.75)
    INTO xMedications (medId, medName, medClass, medType, brand, buyPrice)
    VALUES (2010, 'Valium', 'Sedative', 'Tablet', 'PromAce', 18.50)
    INTO xMedications (medId, medName, medClass, medType, brand, buyPrice)
    VALUES (2011, 'Clavamox', 'Antibiotic', 'Tablet', 'Zoetis', 17.20)
    INTO xMedications (medId, medName, medClass, medType, brand, buyPrice)
    VALUES (2012, 'Cerenia', 'Antiemetic', 'Tablet', 'Zoetis', 21.90)
    INTO xMedications (medId, medName, medClass, medType, brand, buyPrice)
    VALUES (2013, 'Heartgard Plus', 'Heartworm Preventative', 'Chewable', 'Merial', 16.35)
    INTO xMedications (medId, medName, medClass, medType, brand, buyPrice)
    VALUES (2014, 'Ciprofloxacin', 'Antibiotic', 'Tablet', 'Cipro', 14.50)
SELECT * FROM dual;


INSERT ALL
    INTO xPrescriptions (prescriptionId, appointmentDateTime, patientId, dvmId)
    VALUES (3001, TO_DATE('2023-08-05 10:30 AM', 'YYYY-MM-DD HH:MI AM'), 2001, 1016)
    INTO xPrescriptions (prescriptionId, appointmentDateTime, patientId, dvmId)
    VALUES (3002, TO_DATE('2023-08-06 2:15 PM', 'YYYY-MM-DD HH:MI AM'), 2005, 1016)
    INTO xPrescriptions (prescriptionId, appointmentDateTime, patientId, dvmId)
    VALUES (3003, TO_DATE('2023-08-07 11:00 AM', 'YYYY-MM-DD HH:MI AM'), 2010, 1016)
    INTO xPrescriptions (prescriptionId, appointmentDateTime, patientId, dvmId)
    VALUES (3004, TO_DATE('2023-08-08 3:45 PM', 'YYYY-MM-DD HH:MI AM'), 2002, 1016)
    INTO xPrescriptions (prescriptionId, appointmentDateTime, patientId, dvmId)
    VALUES (3005, TO_DATE('2023-08-09 9:00 AM', 'YYYY-MM-DD HH:MI AM'), 2012, 1016)
    INTO xPrescriptions (prescriptionId, appointmentDateTime, patientId, dvmId)
    VALUES (3006, TO_DATE('2023-08-10 12:30 PM', 'YYYY-MM-DD HH:MI AM'), 2008, 1016)
    INTO xPrescriptions (prescriptionId, appointmentDateTime, patientId, dvmId)
    VALUES (3007, TO_DATE('2023-08-11 5:20 PM', 'YYYY-MM-DD HH:MI AM'), 2003, 1016)
    INTO xPrescriptions (prescriptionId, appointmentDateTime, patientId, dvmId)
    VALUES (3008, TO_DATE('2023-08-12 1:40 PM', 'YYYY-MM-DD HH:MI AM'), 2014, 1016)
    INTO xPrescriptions (prescriptionId, appointmentDateTime, patientId, dvmId)
    VALUES (3009, TO_DATE('2023-08-13 4:10 PM', 'YYYY-MM-DD HH:MI AM'), 2015, 1016)
    INTO xPrescriptions (prescriptionId, appointmentDateTime, patientId, dvmId)
    VALUES (3010, TO_DATE('2023-08-14 10:00 AM', 'YYYY-MM-DD HH:MI AM'), 2009, 1016)
    INTO xPrescriptions (prescriptionId, appointmentDateTime, patientId, dvmId)
    VALUES (3011, TO_DATE('2023-08-15 3:00 PM', 'YYYY-MM-DD HH:MI AM'), 2008, 1016)
    INTO xPrescriptions (prescriptionId, appointmentDateTime, patientId, dvmId)
    VALUES (3012, TO_DATE('2023-08-16 11:30 AM', 'YYYY-MM-DD HH:MI AM'), 2015, 1016)
    INTO xPrescriptions (prescriptionId, appointmentDateTime, patientId, dvmId)
    VALUES (3013, TO_DATE('2023-08-17 2:45 PM', 'YYYY-MM-DD HH:MI AM'), 2001, 1016)
    INTO xPrescriptions (prescriptionId, appointmentDateTime, patientId, dvmId)
    VALUES (3014, TO_DATE('2023-08-18 9:45 AM', 'YYYY-MM-DD HH:MI AM'), 2002, 1016)
    INTO xPrescriptions (prescriptionId, appointmentDateTime, patientId, dvmId)
    VALUES (3015, TO_DATE('2023-08-19 4:50 PM', 'YYYY-MM-DD HH:MI AM'), 2003, 1016)
SELECT * FROM dual;



INSERT ALL
    INTO xPrescriptionDetails (prescriptionId, medId, notes) VALUES (3001, 2001, 'Take 1 tablet three times a day after meals.')
    INTO xPrescriptionDetails (prescriptionId, medId, notes) VALUES (3001, 2004, 'Take 1 capsule twice a day as needed for pain relief.')
    INTO xPrescriptionDetails (prescriptionId, medId, notes) VALUES (3002, 2005, 'Administer 1 tablet in the morning for anxiety.')
    INTO xPrescriptionDetails (prescriptionId, medId, notes) VALUES (3002, 2008, 'Apply 1 topical solution once a month for flea and tick prevention.')
    INTO xPrescriptionDetails (prescriptionId, medId, notes) VALUES (3003, 2009, 'Give 1 tablet daily for joint pain.')
    INTO xPrescriptionDetails (prescriptionId, medId, notes) VALUES (3003, 2010, 'Administer 1 injection before travel to help with motion sickness.')
    INTO xPrescriptionDetails (prescriptionId, medId, notes) VALUES (3004, 2002, 'Take 1 tablet twice a day for itch relief.')
    INTO xPrescriptionDetails (prescriptionId, medId, notes) VALUES (3004, 2012, 'Give 1 tablet as needed for vomiting or nausea.')
    INTO xPrescriptionDetails (prescriptionId, medId, notes) VALUES (3005, 2006, 'Give 1 tablet twice a day for bacterial infection.')
    INTO xPrescriptionDetails (prescriptionId, medId, notes) VALUES (3005, 2014, 'Administer 1 capsule daily for calming effect.')
    INTO xPrescriptionDetails (prescriptionId, medId, notes) VALUES (3006, 2007, 'Take 1 tablet in the morning and 1 tablet in the evening for inflammation.')
    INTO xPrescriptionDetails (prescriptionId, medId, notes) VALUES (3007, 2003, 'Apply 1 topical solution once a month for heartworm and parasite prevention.')
    INTO xPrescriptionDetails (prescriptionId, medId, notes) VALUES (3008, 2001, 'Take 1 tablet three times a day after meals.')
    INTO xPrescriptionDetails (prescriptionId, medId, notes) VALUES (3009, 2004, 'Take 1 capsule twice a day as needed for pain relief.')
    INTO xPrescriptionDetails (prescriptionId, medId, notes) VALUES (3010, 2010, 'Administer 1 injection before travel to help with motion sickness.')
    INTO xPrescriptionDetails (prescriptionId, medId, notes) VALUES (3011, 2009, 'Give 1 tablet daily for joint pain.')
    INTO xPrescriptionDetails (prescriptionId, medId, notes) VALUES (3012, 2002, 'Take 1 tablet twice a day for itch relief.')
    INTO xPrescriptionDetails (prescriptionId, medId, notes) VALUES (3013, 2002, 'Take 1 tablet twice a day for itch relief.')
    INTO xPrescriptionDetails (prescriptionId, medId, notes) VALUES (3014, 2012, 'Give 1 tablet as needed for vomiting or nausea.')
    INTO xPrescriptionDetails (prescriptionId, medId, notes) VALUES (3015, 2002, 'Take 1 tablet twice a day for itch relief.')
    INTO xPrescriptionDetails (prescriptionId, medId, notes) VALUES (3015, 2012, 'Give 1 tablet as needed for vomiting or nausea.')
SELECT * FROM DUAL;


INSERT ALL
    INTO xProcedures (procedureId, procedureName, employeeId, currentServiceRate) VALUES (4001, 'Dental Cleaning', 1016, 150.00)
    INTO xProcedures (procedureId, procedureName, employeeId, currentServiceRate) VALUES (4002, 'Vaccination', 1016, 80.00)
    INTO xProcedures (procedureId, procedureName, employeeId, currentServiceRate) VALUES (4003, 'Spay', 1016, 900.00)
    INTO xProcedures (procedureId, procedureName, employeeId, currentServiceRate) VALUES (4004, 'Neuter', 1016, 1000.00)
    INTO xProcedures (procedureId, procedureName, employeeId, currentServiceRate) VALUES (4005, 'Nail Trim', 1017, 20.00)
    INTO xProcedures (procedureId, procedureName, employeeId, currentServiceRate) VALUES (4006, 'Bath and Brush', 1017, 30.00)
    INTO xProcedures (procedureId, procedureName, employeeId, currentServiceRate) VALUES (4007, 'Grooming', 1017, 50.00)
    INTO xProcedures (procedureId, procedureName, employeeId, currentServiceRate) VALUES (4008, 'X-ray', 1019, 120.00)
    INTO xProcedures (procedureId, procedureName, employeeId, currentServiceRate) VALUES (4009, 'Blood Test', 1019, 80.00)
    INTO xProcedures (procedureId, procedureName, employeeId, currentServiceRate) VALUES (4010, 'Ultrasound', 1016, 180.00)
    INTO xProcedures (procedureId, procedureName, employeeId, currentServiceRate) VALUES (4011, 'Microchipping', 1016, 35.00)
    INTO xProcedures (procedureId, procedureName, employeeId, currentServiceRate) VALUES (4012, 'Eye Examination', 1016, 60.00)
    INTO xProcedures (procedureId, procedureName, employeeId, currentServiceRate) VALUES (4013, 'Dental Extraction', 1016, 180.00)
    INTO xProcedures (procedureId, procedureName, employeeId, currentServiceRate) VALUES (4014, 'Physical Examination', 1016, 40.00)
    INTO xProcedures (procedureId, procedureName, employeeId, currentServiceRate) VALUES (4015, 'Wound Dressing', 1019, 25.00)
    INTO xProcedures (procedureId, procedureName, employeeId, currentServiceRate) VALUES (4016, 'Allergy Testing', 1016, 100.00)
    INTO xProcedures (procedureId, procedureName, employeeId, currentServiceRate) VALUES (4017, 'Anal Gland Expression', 1017, 30.00)
    INTO xProcedures (procedureId, procedureName, employeeId, currentServiceRate) VALUES (4018, 'Fecal Examination', 1019, 15.00)
    INTO xProcedures (procedureId, procedureName, employeeId, currentServiceRate) VALUES (4019, 'Heartworm Test', 1016, 40.00)
    INTO xProcedures (procedureId, procedureName, employeeId, currentServiceRate) VALUES (4020, 'Ear Cleaning', 1017, 25.00)
    INTO xProcedures (procedureId, procedureName, employeeId, currentServiceRate) VALUES (4021, 'Annual Exam Gold Package', 1016, 500.00)
    INTO xProcedures (procedureId, procedureName, employeeId, currentServiceRate) VALUES (4022, 'Annual Exam Silver Package', 1016, 300.00)
    INTO xProcedures (procedureId, procedureName, employeeId, currentServiceRate) VALUES (4023, 'Puppy Initial Visit', 1016, 120.00)
    INTO xProcedures (procedureId, procedureName, employeeId, currentServiceRate) VALUES (4024, 'Puppy Second Visit', 1016, 100.00)
SELECT * FROM DUAL;


INSERT ALL
    INTO xAppointments (appointmentId, apptDateTime, patientId) VALUES (5201, TO_TIMESTAMP('2021-09-07 14:30:00', 'YYYY-MM-DD HH24:MI:SS'), 2002)
    INTO xAppointments (appointmentId, apptDateTime, patientId) VALUES (5202, TO_TIMESTAMP('2021-09-08 11:15:00', 'YYYY-MM-DD HH24:MI:SS'), 2003)
    INTO xAppointments (appointmentId, apptDateTime, patientId) VALUES (5203, TO_TIMESTAMP('2021-09-09 15:45:00', 'YYYY-MM-DD HH24:MI:SS'), 2004)
    INTO xAppointments (appointmentId, apptDateTime, patientId) VALUES (5204, TO_TIMESTAMP('2021-09-10 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), 2005)
    INTO xAppointments (appointmentId, apptDateTime, patientId) VALUES (5205, TO_TIMESTAMP('2021-09-11 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2006)
    INTO xAppointments (appointmentId, apptDateTime, patientId) VALUES (5206, TO_TIMESTAMP('2022-09-09 15:45:00', 'YYYY-MM-DD HH24:MI:SS'), 2004)
    INTO xAppointments (appointmentId, apptDateTime, patientId) VALUES (5207, TO_TIMESTAMP('2022-09-10 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), 2005)
    INTO xAppointments (appointmentId, apptDateTime, patientId) VALUES (5208, TO_TIMESTAMP('2022-09-11 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2006)
    INTO xAppointments (appointmentId, apptDateTime, patientId) VALUES (5209, TO_TIMESTAMP('2022-09-12 16:20:00', 'YYYY-MM-DD HH24:MI:SS'), 2007)
    INTO xAppointments (appointmentId, apptDateTime, patientId) VALUES (5210, TO_TIMESTAMP('2022-09-09 15:45:00', 'YYYY-MM-DD HH24:MI:SS'), 2004)
    INTO xAppointments (appointmentId, apptDateTime, patientId) VALUES (5211, TO_TIMESTAMP('2022-09-10 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), 2005)
    INTO xAppointments (appointmentId, apptDateTime, patientId) VALUES (5212, TO_TIMESTAMP('2023-09-11 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2006)
    INTO xAppointments (appointmentId, apptDateTime, patientId) VALUES (5213, TO_TIMESTAMP('2023-09-12 16:20:00', 'YYYY-MM-DD HH24:MI:SS'), 2007)
    INTO xAppointments (appointmentId, apptDateTime, patientId) VALUES (5214, TO_TIMESTAMP('2023-09-06 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2001)
    INTO xAppointments (appointmentId, apptDateTime, patientId) VALUES (5215, TO_TIMESTAMP('2023-09-07 14:30:00', 'YYYY-MM-DD HH24:MI:SS'), 2002)
    INTO xAppointments (appointmentId, apptDateTime, patientId) VALUES (5216, TO_TIMESTAMP('2023-09-08 11:15:00', 'YYYY-MM-DD HH24:MI:SS'), 2003)
    INTO xAppointments (appointmentId, apptDateTime, patientId) VALUES (5217, TO_TIMESTAMP('2023-09-09 15:45:00', 'YYYY-MM-DD HH24:MI:SS'), 2004)
    INTO xAppointments (appointmentId, apptDateTime, patientId) VALUES (5218, TO_TIMESTAMP('2023-09-10 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), 2005)
    INTO xAppointments (appointmentId, apptDateTime, patientId) VALUES (5219, TO_TIMESTAMP('2023-09-11 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2006)
    INTO xAppointments (appointmentId, apptDateTime, patientId) VALUES (5220, TO_TIMESTAMP('2023-09-12 16:20:00', 'YYYY-MM-DD HH24:MI:SS'), 2007)
    INTO xAppointments (appointmentId, apptDateTime, patientId) VALUES (5221, TO_TIMESTAMP('2023-09-13 13:30:00', 'YYYY-MM-DD HH24:MI:SS'), 2008)
    INTO xAppointments (appointmentId, apptDateTime, patientId) VALUES (5222, TO_TIMESTAMP('2023-09-14 15:10:00', 'YYYY-MM-DD HH24:MI:SS'), 2009)
    INTO xAppointments (appointmentId, apptDateTime, patientId) VALUES (5223, TO_TIMESTAMP('2023-09-15 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 2010)
    INTO xAppointments (appointmentId, apptDateTime, patientId) VALUES (5224, TO_TIMESTAMP('2023-09-16 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2011)
    INTO xAppointments (appointmentId, apptDateTime, patientId) VALUES (5225, TO_TIMESTAMP('2023-09-17 11:30:00', 'YYYY-MM-DD HH24:MI:SS'), 2012)
    INTO xAppointments (appointmentId, apptDateTime, patientId) VALUES (5226, TO_TIMESTAMP('2024-09-18 14:45:00', 'YYYY-MM-DD HH24:MI:SS'), 2013)
    INTO xAppointments (appointmentId, apptDateTime, patientId) VALUES (5227, TO_TIMESTAMP('2024-09-19 09:45:00', 'YYYY-MM-DD HH24:MI:SS'), 2014)
    INTO xAppointments (appointmentId, apptDateTime, patientId) VALUES (5228, TO_TIMESTAMP('2024-09-20 16:50:00', 'YYYY-MM-DD HH24:MI:SS'), 2015)
SELECT * FROM DUAL;



INSERT ALL
    INTO xAppointmentsDetails (appointmentDateTime, procedureId) VALUES (TO_TIMESTAMP('2023-03-05 10:00 AM', 'YYYY-MM-DD HH:MI AM'), 4001)
    INTO xAppointmentsDetails (appointmentDateTime, procedureId) VALUES (TO_TIMESTAMP('2023-03-10 2:30 PM', 'YYYY-MM-DD HH:MI PM'), 4002)
    INTO xAppointmentsDetails (appointmentDateTime, procedureId) VALUES (TO_TIMESTAMP('2023-03-15 11:15 AM', 'YYYY-MM-DD HH:MI AM'), 4003)
    INTO xAppointmentsDetails (appointmentDateTime, procedureId) VALUES (TO_TIMESTAMP('2023-03-20 3:45 PM', 'YYYY-MM-DD HH:MI PM'), 4004)
    INTO xAppointmentsDetails (appointmentDateTime, procedureId) VALUES (TO_TIMESTAMP('2023-03-25 9:30 AM', 'YYYY-MM-DD HH:MI AM'), 4005)
    INTO xAppointmentsDetails (appointmentDateTime, procedureId) VALUES (TO_TIMESTAMP('2023-04-05 10:00 AM', 'YYYY-MM-DD HH:MI AM'), 4006)
    INTO xAppointmentsDetails (appointmentDateTime, procedureId) VALUES (TO_TIMESTAMP('2023-04-10 2:30 PM', 'YYYY-MM-DD HH:MI PM'), 4007)
    INTO xAppointmentsDetails (appointmentDateTime, procedureId) VALUES (TO_TIMESTAMP('2023-04-15 11:15 AM', 'YYYY-MM-DD HH:MI AM'), 4008)
    INTO xAppointmentsDetails (appointmentDateTime, procedureId) VALUES (TO_TIMESTAMP('2023-04-20 3:45 PM', 'YYYY-MM-DD HH:MI PM'), 4009)
    INTO xAppointmentsDetails (appointmentDateTime, procedureId) VALUES (TO_TIMESTAMP('2023-04-25 9:30 AM', 'YYYY-MM-DD HH:MI AM'), 4010)
    INTO xAppointmentsDetails (appointmentDateTime, procedureId) VALUES (TO_TIMESTAMP('2023-05-05 2:00 PM', 'YYYY-MM-DD HH:MI PM'), 4011)
    INTO xAppointmentsDetails (appointmentDateTime, procedureId) VALUES (TO_TIMESTAMP('2023-05-10 11:30 AM', 'YYYY-MM-DD HH:MI AM'), 4012)
    INTO xAppointmentsDetails (appointmentDateTime, procedureId) VALUES (TO_TIMESTAMP('2023-05-15 3:45 PM', 'YYYY-MM-DD HH:MI PM'), 4013)
    INTO xAppointmentsDetails (appointmentDateTime, procedureId) VALUES (TO_TIMESTAMP('2023-05-20 9:30 AM', 'YYYY-MM-DD HH:MI AM'), 4014)
    INTO xAppointmentsDetails (appointmentDateTime, procedureId) VALUES (TO_TIMESTAMP('2023-05-25 12:00 PM', 'YYYY-MM-DD HH:MI PM'), 4015)
    INTO xAppointmentsDetails (appointmentDateTime, procedureId) VALUES (TO_TIMESTAMP('2023-06-05 10:00 AM', 'YYYY-MM-DD HH:MI AM'), 4016)
    INTO xAppointmentsDetails (appointmentDateTime, procedureId) VALUES (TO_TIMESTAMP('2023-06-10 2:30 PM', 'YYYY-MM-DD HH:MI PM'), 4017)
    INTO xAppointmentsDetails (appointmentDateTime, procedureId) VALUES (TO_TIMESTAMP('2023-06-15 11:15 AM', 'YYYY-MM-DD HH:MI AM'), 4018)
    INTO xAppointmentsDetails (appointmentDateTime, procedureId) VALUES (TO_TIMESTAMP('2023-06-20 3:45 PM', 'YYYY-MM-DD HH:MI PM'), 4019)
    INTO xAppointmentsDetails (appointmentDateTime, procedureId) VALUES (TO_TIMESTAMP('2023-06-25 9:30 AM', 'YYYY-MM-DD HH:MI AM'), 4020)
    INTO xAppointmentsDetails (appointmentDateTime, procedureId) VALUES (TO_TIMESTAMP('2023-07-06 10:00 AM', 'YYYY-MM-DD HH:MI AM'), 4021)
    INTO xAppointmentsDetails (appointmentDateTime, procedureId) VALUES (TO_TIMESTAMP('2023-07-07 2:30 PM', 'YYYY-MM-DD HH:MI PM'), 4022)
    INTO xAppointmentsDetails (appointmentDateTime, procedureId) VALUES (TO_TIMESTAMP('2023-07-08 11:15 AM', 'YYYY-MM-DD HH:MI AM'), 4023)
    INTO xAppointmentsDetails (appointmentDateTime, procedureId) VALUES (TO_TIMESTAMP('2023-07-09 3:45 PM', 'YYYY-MM-DD HH:MI PM'), 4024)
    INTO xAppointmentsDetails (appointmentDateTime, procedureId) VALUES (TO_TIMESTAMP('2023-08-10 9:30 AM', 'YYYY-MM-DD HH:MI AM'), 4001)
    INTO xAppointmentsDetails (appointmentDateTime, procedureId) VALUES (TO_TIMESTAMP('2023-08-11 2:00 PM', 'YYYY-MM-DD HH:MI PM'), 4002)
    INTO xAppointmentsDetails (appointmentDateTime, procedureId) VALUES (TO_TIMESTAMP('2023-08-12 11:30 AM', 'YYYY-MM-DD HH:MI AM'), 4003)
    INTO xAppointmentsDetails (appointmentDateTime, procedureId) VALUES (TO_TIMESTAMP('2023-08-13 3:45 PM', 'YYYY-MM-DD HH:MI PM'), 4004)
    INTO xAppointmentsDetails (appointmentDateTime, procedureId) VALUES (TO_TIMESTAMP('2023-08-14 9:30 AM', 'YYYY-MM-DD HH:MI AM'), 4005)
    INTO xAppointmentsDetails (appointmentDateTime, procedureId) VALUES (TO_TIMESTAMP('2024-03-05 10:00 AM', 'YYYY-MM-DD HH:MI AM'), 4001)
    INTO xAppointmentsDetails (appointmentDateTime, procedureId) VALUES (TO_TIMESTAMP('2024-03-10 2:30 PM', 'YYYY-MM-DD HH:MI PM'), 4002)
    INTO xAppointmentsDetails (appointmentDateTime, procedureId) VALUES (TO_TIMESTAMP('2024-03-15 11:15 AM', 'YYYY-MM-DD HH:MI AM'), 4003)
    INTO xAppointmentsDetails (appointmentDateTime, procedureId) VALUES (TO_TIMESTAMP('2024-03-20 3:45 PM', 'YYYY-MM-DD HH:MI PM'), 4004)
    INTO xAppointmentsDetails (appointmentDateTime, procedureId) VALUES (TO_TIMESTAMP('2024-03-25 9:30 AM', 'YYYY-MM-DD HH:MI AM'), 4005)
    INTO xAppointmentsDetails (appointmentDateTime, procedureId) VALUES (TO_TIMESTAMP('2024-04-05 10:00 AM', 'YYYY-MM-DD HH:MI AM'), 4006)
    INTO xAppointmentsDetails (appointmentDateTime, procedureId) VALUES (TO_TIMESTAMP('2024-04-10 2:30 PM', 'YYYY-MM-DD HH:MI PM'), 4007)
SELECT * FROM DUAL;

INSERT ALL
    INTO xInvoices (invoiceId, patientId, dateAndTime)
    VALUES (9000, 2002, TO_TIMESTAMP('2023-03-07 14:30:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO xInvoices (invoiceId, patientId, dateAndTime)
    VALUES (9001, 2003, TO_TIMESTAMP('2023-03-08 11:15:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO xInvoices (invoiceId, patientId, dateAndTime)
    VALUES (9002, 2004, TO_TIMESTAMP('2023-03-09 15:45:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO xInvoices (invoiceId, patientId, dateAndTime)
    VALUES (9003, 2005, TO_TIMESTAMP('2023-03-10 09:30:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO xInvoices (invoiceId, patientId, dateAndTime)
    VALUES (9004, 2006, TO_TIMESTAMP('2023-03-11 12:00:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO xInvoices (invoiceId, patientId, dateAndTime)
    VALUES (9005, 2004, TO_TIMESTAMP('2023-04-09 15:45:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO xInvoices (invoiceId, patientId, dateAndTime)
    VALUES (9006, 2005, TO_TIMESTAMP('2023-04-10 09:30:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO xInvoices (invoiceId, patientId, dateAndTime)
    VALUES (9007, 2006, TO_TIMESTAMP('2023-04-11 12:00:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO xInvoices (invoiceId, patientId, dateAndTime)
    VALUES (9008, 2007, TO_TIMESTAMP('2023-04-12 16:20:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO xInvoices (invoiceId, patientId, dateAndTime)
    VALUES (9009, 2004, TO_TIMESTAMP('2023-05-09 15:45:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO xInvoices (invoiceId, patientId, dateAndTime)
    VALUES (9010, 2005, TO_TIMESTAMP('2023-05-10 09:30:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO xInvoices (invoiceId, patientId, dateAndTime)
    VALUES (9011, 2006, TO_TIMESTAMP('2023-05-11 12:00:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO xInvoices (invoiceId, patientId, dateAndTime)
    VALUES (9012, 2007, TO_TIMESTAMP('2023-05-12 16:20:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO xInvoices (invoiceId, patientId, dateAndTime)
    VALUES (9013, 2001, TO_TIMESTAMP('2023-05-06 10:00:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO xInvoices (invoiceId, patientId, dateAndTime)
    VALUES (9014, 2002, TO_TIMESTAMP('2023-05-07 14:30:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO xInvoices (invoiceId, patientId, dateAndTime)
    VALUES (9015, 2003, TO_TIMESTAMP('2023-05-08 11:15:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO xInvoices (invoiceId, patientId, dateAndTime)
    VALUES (9016, 2004, TO_TIMESTAMP('2023-05-09 15:45:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO xInvoices (invoiceId, patientId, dateAndTime)
    VALUES (9017, 2005, TO_TIMESTAMP('2023-05-10 09:30:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO xInvoices (invoiceId, patientId, dateAndTime)
    VALUES (9018, 2006, TO_TIMESTAMP('2023-05-11 12:00:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO xInvoices (invoiceId, patientId, dateAndTime)
    VALUES (9019, 2007, TO_TIMESTAMP('2023-05-12 16:20:00', 'YYYY-MM-DD HH24:MI:SS'))
SELECT * FROM DUAL;


INSERT ALL
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (1, 9001, 4001, 2001, 50.00) 
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (2, 9001, 4002, NULL, 75.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (3, 9001, NULL, 2003, 60.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (1, 9002, 4003, NULL, 70.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (2, 9002, NULL, 2002, 40.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (3, 9002, 4004, 2004, 90.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (1, 9003, 4005, 2005, 55.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (2, 9003, 4006, NULL, 80.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (3, 9003, NULL, 2006, 65.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (1, 9004, 4007, 2007, 70.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (2, 9004, NULL, 2008, 45.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (3, 9004, 4008, NULL, 85.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (1, 9005, 4009, 2009, 60.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (2, 9005, 4010, NULL, 90.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (3, 9005, NULL, 2010, 75.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (1, 9006, 4011, 2011, 80.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (2, 9006, 4012, NULL, 65.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (3, 9006, NULL, 2012, 95.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (1, 9007, 4013, 2013, 70.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
   VALUES (2, 9007, NULL, 2014, 45.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (3, 9007, 4014, NULL, 85.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (1, 9008, 4001, 2001, 50.00) 
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (2, 9008, 4002, NULL, 75.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (3, 9008, NULL, 2003, 60.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (1, 9009, 4003, NULL, 70.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (2, 9009, NULL, 2002, 40.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (3, 9009, 4004, 2004, 90.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (1, 9010, 4005, 2005, 55.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (2, 9010, 4006, NULL, 80.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (3, 9010, NULL, 2006, 65.00)
        INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (1, 9011, 4001, 2001, 50.00) 
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (2, 9011, 4002, NULL, 75.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (3, 9011, NULL, 2003, 60.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (1, 9012, 4003, NULL, 70.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (2, 9012, NULL, 2002, 40.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (3, 9012, 4004, 2004, 90.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (1, 9013, 4005, 2005, 55.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (2, 9013, 4006, NULL, 80.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (3, 9013, NULL, 2006, 65.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (1, 9014, 4007, 2007, 70.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (2, 9014, NULL, 2008, 45.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (3, 9014, 4008, NULL, 85.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (1, 9015, 4009, 2009, 60.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (2, 9015, 4010, NULL, 90.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (3, 9015, NULL, 2010, 75.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (1, 9016, 4011, 2011, 80.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (2, 9016, 4012, NULL, 65.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (3, 9016, NULL, 2012, 95.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (1, 9017, 4013, 2013, 70.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (2, 9017, NULL, 2014, 45.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (3, 9017, 4014, NULL, 85.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (1, 9018, 4001, 2001, 50.00) 
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (2, 9018, 4002, NULL, 75.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (3, 9018, NULL, 2003, 60.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (1, 9019, 4003, NULL, 70.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (2, 9019, NULL, 2002, 40.00)
    INTO xInvoiceDetails (lineNumber, invoiceId, procedureId, medicationId, pricePaid)
    VALUES (3, 9019, 4004, 2004, 90.00) 
SELECT * FROM DUAL;

