-- ==============================================================================
-- Script: 2_etl_data_cleansing.sql
-- Purpose: Cleanse raw data, handle anomalies, and integrate into Fact table
-- ==============================================================================

-- 1. Standardize and Cleanse Staging Data
-- Resolving NULL values and standardizing status text
UPDATE Staging_Encounters
SET EncounterStatus = 'No-Show'
WHERE EncounterStatus IS NULL OR EncounterStatus = 'NS';

-- 2. Data Quality Audit: Flag illogical timestamps (Discharge before Check-In)
UPDATE Staging_Encounters
SET DataQualityFlag = 1
WHERE DischargeTime < CheckInTime;

-- 3. Load into Fact Table (Multi-source integration simulation)
INSERT INTO Fact_PatientEncounter (
    EncounterID, PatientID, FacilityID, AppointmentDate, 
    CheckInTime, ProviderSeenTime, DischargeTime, EncounterStatus, DataQualityFlag
)
SELECT 
    stg.EncounterID,
    COALESCE(p.PatientID, -1) AS PatientID, -- Handle orphaned records
    f.FacilityID,
    stg.AppointmentDate,
    stg.CheckInTime,
    stg.ProviderSeenTime,
    stg.DischargeTime,
    stg.EncounterStatus,
    stg.DataQualityFlag
FROM Staging_Encounters stg
LEFT JOIN Dim_Patient p ON stg.SourcePatientMRN = p.MedicalRecordNumber
LEFT JOIN Dim_Facility f ON stg.SourceClinicCode = f.ClinicCode
WHERE stg.DataQualityFlag = 0; -- Only load clean data into reporting fact table
