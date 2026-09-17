-- ==============================================================================
-- Script: 1_ddl_schema_setup.sql
-- Purpose: Create relational Star Schema for Healthcare Throughput Data Mart
-- ==============================================================================

-- Create Dimension Tables
CREATE TABLE Dim_Facility (
    FacilityID INT PRIMARY KEY,
    FacilityName VARCHAR(100),
    Region VARCHAR(50),
    FacilityType VARCHAR(50)
);

CREATE TABLE Dim_Patient (
    PatientID INT PRIMARY KEY,
    DateOfBirth DATE,
    Gender VARCHAR(10),
    ZipCode VARCHAR(10)
);

-- Create Fact Table for Encounters (Throughput)
CREATE TABLE Fact_PatientEncounter (
    EncounterID INT PRIMARY KEY,
    PatientID INT FOREIGN KEY REFERENCES Dim_Patient(PatientID),
    FacilityID INT FOREIGN KEY REFERENCES Dim_Facility(FacilityID),
    AppointmentDate DATE,
    CheckInTime DATETIME,
    ProviderSeenTime DATETIME,
    DischargeTime DATETIME,
    EncounterStatus VARCHAR(20), -- e.g., 'Completed', 'No-Show', 'Cancelled'
    DataQualityFlag INT DEFAULT 0
);
