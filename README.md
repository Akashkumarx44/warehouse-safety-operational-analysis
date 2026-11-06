# Warehouse Safety & Operational Performance Analysis

## Project Overview
This independent data analysis project evaluates warehouse safety and operational performance using SQL and Microsoft Excel.

The objective is to identify incident patterns, analyse warehouse performance, calculate key performance indicators (KPIs), and provide data-driven recommendations.

## Tools Used
- MySQL 8.0
- Microsoft Excel
- SQL
- PivotTables and Charts

## Project Activities

### 1. Data Cleaning
- Identified duplicate incident records.
- Used ROW_NUMBER() to identify and remove duplicate records from the analysis.
- Standardised severity values using UPPER().
- Used Common Table Expressions (CTEs) to organise the cleaning process.

### 2. SQL Analysis
Calculated the following KPIs:
- Total incidents by warehouse.
- High-severity incident count.
- High-severity incident percentage.
- Incident rate.
- Total lost days.
- Average lost days per incident.

### 3. Excel Dashboard
Created an interactive analytical workbook containing:
- KPI summary.
- Warehouse severity analysis.
- Raw and cleaned data.
- Warehouse performance summary.
- Charts for visual analysis.

## Key Findings
- CHN1 recorded the highest incident rate at 0.375%.
- BLR1 and CHN1 had the highest high-severity incident percentage at 66.67%.
- CHN1 recorded the highest total lost days at 23 days.
- CHN1 had the highest average lost days per incident at 7.67 days.
- MAA1 recorded the lowest incident rate at approximately 0.222%.

## Business Recommendations
- Prioritise CHN1 for further investigation.
- Investigate recurring high-severity incidents in BLR1.
- Review equipment maintenance and safety procedures.
- Monitor warehouse performance using regular KPI reporting.

## Project Files
- Warehouse_Analysis.xlsx – Excel analysis and dashboard.
- Warehouse_Analysis.sql – SQL queries used for data cleaning and analysis.
- Project_Summary.pdf – Project documentation.

## Dataset Note
This is an independent practice project using a sample dataset created for learning and demonstration purposes. It does not contain actual Amazon operational data.
