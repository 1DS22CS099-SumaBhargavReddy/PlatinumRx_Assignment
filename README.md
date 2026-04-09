# PlatinumRx Data Analyst Assignment

Here are my solutions for the data analysis assignment tasks.

## Folder structure

- `SQL/` contains table creation scripts and query solutions for both Hotel and Clinic assignments.
- `Spreadsheets/` contains the `Ticket_Analysis.xlsx` with VLOOKUP/INDEX-MATCH and COUNTIFS formulas.
- `Python/` has two scripts for time conversion and removing string duplicates.

## Notes & Approach

- **SQL:** I added sample data spanning a few months in 2021 to properly test the queries (especially things like finding the most ordered item per month). I used window functions like `RANK()` and `DENSE_RANK()` as recommended in the prompt for finding top/bottom records.
- **Spreadsheets:** I used `INDEX` and `MATCH` for the first question because the lookup id (`cms_id`) was at the end of the tickets table, making a standard `VLOOKUP` a bit restrictive without reordering columns. Added helper columns for pulling the date and hour to do the counts using `COUNTIFS`.
- **Python:** Kept the scripts simple and directly answered the prompt logic utilizing standard integer division for time conversion and a basic string looping mechanism to remove duplicates.
"# PlatinumRx_Assignment" 
