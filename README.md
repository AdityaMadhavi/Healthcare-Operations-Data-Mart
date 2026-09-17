# Healthcare-Operations-Data-Mart
End-to-end healthcare data mart demonstrating multi-source ETL, data quality audits in T-SQL, and optimized views for Power BI throughput scorecards

## Business Objective
Designed an end-to-end data pipeline and analytical model to track patient throughput, clinic utilization, and data quality metrics for a mock healthcare network. This project demonstrates the extraction, transformation, and loading (ETL) of raw operational healthcare data into a structured Data Mart optimized for Power BI consumption.

## Technical Architecture
* **Database:** MS SQL Server / Azure SQL
* **Data Integration:** T-SQL (Stored Procedures, Views, Data Quality Audits)
* **Visualization:** Power BI (Dashboards & Scorecards)
* **Key Performance Indicators (KPIs):** Average Patient Wait Time, Daily Throughput Volume, Appointment No-Show Rates, Data Quality Anomaly Score.

## Repository Structure
* `/sql_scripts/1_ddl_schema_setup.sql` - Table creation and relational schema design.
* `/sql_scripts/2_etl_data_cleansing.sql` - Ingestion, multi-source data integration, and quality cleanup.
* `/sql_scripts/3_powerbi_views.sql` - Complex query design tailored for Power BI reporting.
* `/dashboard/` - (Screenshots of the Power BI visual aesthetic).

## Data Quality & Governance
Implemented automated data quality audits to flag orphaned records, missing demographic data, and logical timestamp errors (e.g., discharge time occurring before admission time), ensuring high integrity for executive reporting.
