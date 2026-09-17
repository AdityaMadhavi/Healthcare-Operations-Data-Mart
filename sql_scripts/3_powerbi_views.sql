-- ==============================================================================
-- Script: 3_powerbi_views.sql
-- Purpose: Aggregate data for Power BI consumption and KPI Scorecards
-- ==============================================================================

CREATE VIEW vw_PowerBI_DailyThroughput AS
SELECT 
    f.FacilityName,
    e.AppointmentDate,
    COUNT(e.EncounterID) AS TotalEncounters,
    SUM(CASE WHEN e.EncounterStatus = 'No-Show' THEN 1 ELSE 0 END) AS TotalNoShows,
    -- Calculate No-Show Rate
    CAST(SUM(CASE WHEN e.EncounterStatus = 'No-Show' THEN 1 ELSE 0 END) AS FLOAT) / 
        COUNT(e.EncounterID) AS NoShowRate,
    -- Calculate Average Wait Time in Minutes
    AVG(DATEDIFF(MINUTE, e.CheckInTime, e.ProviderSeenTime)) AS AvgWaitTimeMinutes
FROM Fact_PatientEncounter e
JOIN Dim_Facility f ON e.FacilityID = f.FacilityID
WHERE e.DataQualityFlag = 0
GROUP BY 
    f.FacilityName,
    e.AppointmentDate;
