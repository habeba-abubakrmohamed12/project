-- SQL Schema for Hospital Management System
-- Dialect: MySQL
-- Naming Convention: snake_case
-- String Type: VARCHAR(255)
-- Decimal Type: DECIMAL(10,2)

-- Table: departments
CREATE TABLE departments (
    department_id VARCHAR(255) PRIMARY KEY,
    name VARCHAR(255),
    floor VARCHAR(255)
);

-- Table: doctors
CREATE TABLE doctors (
    doctor_id VARCHAR(255) PRIMARY KEY,
    name VARCHAR(255),
    specialty VARCHAR(255),
    contact_info VARCHAR(255),
    department_id VARCHAR(255),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Table: patients
CREATE TABLE patients (
    patient_id VARCHAR(255) PRIMARY KEY,
    name VARCHAR(255),
    gender VARCHAR(255),
    date_of_birth DATE,
    contact_info VARCHAR(255)
);

-- Table: appointments
CREATE TABLE appointments (
    appointment_id VARCHAR(255) PRIMARY KEY,
    patient_id VARCHAR(255),
    doctor_id VARCHAR(255),
    appointment_date DATE,
    appointment_time TIME,
    status VARCHAR(255),
    appointment_type VARCHAR(255),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

-- Table: invoices
CREATE TABLE invoices (
    invoice_id VARCHAR(255) PRIMARY KEY,
    patient_id VARCHAR(255),
    amount DECIMAL(10,2),
    invoice_date DATE,
    payment_status VARCHAR(255),
    payment_method VARCHAR(255),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);



-- Sample Data Insertion

-- Insert data into departments
INSERT INTO departments (department_id, name, floor) VALUES
('DEP001', 'Cardiology', '1st Floor'),
('DEP002', 'Neurology', '2nd Floor'),
('DEP003', 'Pediatrics', '3rd Floor'),
('DEP004', 'Orthopedics', '4th Floor'),
('DEP005', 'Oncology', '5th Floor');

-- Insert data into doctors
INSERT INTO doctors (doctor_id, name, specialty, contact_info, department_id) VALUES
('DOC001', 'Dr. Alice Smith', 'Cardiologist', 'alice.smith@hospital.com', 'DEP001'),
('DOC002', 'Dr. Bob Johnson', 'Neurologist', 'bob.johnson@hospital.com', 'DEP002'),
('DOC003', 'Dr. Carol White', 'Pediatrician', 'carol.white@hospital.com', 'DEP003'),
('DOC004', 'Dr. David Brown', 'Orthopedic Surgeon', 'david.brown@hospital.com', 'DEP004'),
('DOC005', 'Dr. Eve Davis', 'Oncologist', 'eve.davis@hospital.com', 'DEP005');

-- Insert data into patients
INSERT INTO patients (patient_id, name, gender, date_of_birth, contact_info) VALUES
('PAT001', 'John Doe', 'Male', '1985-06-15', 'john.doe@email.com'),
('PAT002', 'Jane Roe', 'Female', '1992-03-22', 'jane.roe@email.com'),
('PAT003', 'Mike Ross', 'Male', '1978-11-01', 'mike.ross@email.com'),
('PAT004', 'Sara Connor', 'Female', '2001-07-30', 'sara.connor@email.com'),
('PAT005', 'Tom Hanks', 'Male', '1956-07-09', 'tom.hanks@email.com');

-- Insert data into appointments
INSERT INTO appointments (appointment_id, patient_id, doctor_id, appointment_date, appointment_time, status, appointment_type) VALUES
('APP001', 'PAT001', 'DOC001', '2025-05-20', '10:00:00', 'Scheduled', 'Consultation'),
('APP002', 'PAT002', 'DOC002', '2025-05-21', '11:30:00', 'Scheduled', 'Follow-up'),
('APP003', 'PAT003', 'DOC003', '2025-05-22', '09:00:00', 'Completed', 'Check-up'),
('APP004', 'PAT004', 'DOC004', '2025-05-23', '14:00:00', 'Scheduled', 'Surgery Prep'),
('APP005', 'PAT005', 'DOC005', '2025-05-24', '16:00:00', 'Cancelled', 'Consultation');

-- Insert data into invoices
INSERT INTO invoices (invoice_id, patient_id, amount, invoice_date, payment_status, payment_method) VALUES
('INV001', 'PAT001', 150.00, '2025-05-20', 'Paid', 'Credit Card'),
('INV002', 'PAT002', 75.50, '2025-05-21', 'Pending', 'Cash'),
('INV003', 'PAT003', 200.00, '2025-05-22', 'Paid', 'Insurance'),
('INV004', 'PAT001', 50.00, '2025-05-23', 'Unpaid', 'N/A'),
('INV005', 'PAT004', 120.75, '2025-05-24', 'Paid', 'Debit Card');

