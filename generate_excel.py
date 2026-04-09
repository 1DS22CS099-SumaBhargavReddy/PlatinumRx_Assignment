import os
from openpyxl import Workbook

# create folder
if not os.path.exists("Spreadsheets"):
    os.makedirs("Spreadsheets")

wb = Workbook()

# ------------------ SHEET 1: TICKET ------------------
ws_ticket = wb.active
ws_ticket.title = "ticket"

# headers
ws_ticket.append([
    "ticket_id", "created_at", "closed_at", "outlet_id", "cms_id",
    "Same Day?", "Same Hour?"
])

# sample data (more realistic & expanded)
data = [
    ["tkt-001", "2021-08-19 10:15:00", "2021-08-19 12:30:00", "outlet-1", "cms-001"],
    ["tkt-002", "2021-08-19 14:00:00", "2021-08-20 09:00:00", "outlet-2", "cms-002"],
    ["tkt-003", "2021-08-20 11:00:00", "2021-08-20 11:45:00", "outlet-1", "cms-003"],
    ["tkt-004", "2021-08-20 13:20:00", "2021-08-20 15:00:00", "outlet-3", "cms-004"],
    ["tkt-005", "2021-08-21 09:00:00", "2021-08-21 09:30:00", "outlet-2", "cms-005"],
    ["tkt-006", "2021-08-21 10:00:00", "2021-08-21 14:00:00", "outlet-1", "cms-006"],
    ["tkt-007", "2021-08-22 08:00:00", "2021-08-22 08:45:00", "outlet-3", "cms-007"],
    ["tkt-008", "2021-08-22 11:30:00", "2021-08-23 10:00:00", "outlet-2", "cms-008"],
]

# insert rows with formulas
for i, row in enumerate(data, start=2):
    ws_ticket.append(row + [
        f'=INT(B{i})=INT(C{i})',  # Same Day
        f'=TEXT(B{i},"yyyy-mm-dd hh")=TEXT(C{i},"yyyy-mm-dd hh")'  # Same Hour
    ])

# ------------------ SUMMARY ------------------
ws_ticket.append([])
ws_ticket.append(["Outlet", "Same Day Count", "Same Hour Count"])

outlets = ["outlet-1", "outlet-2", "outlet-3"]

for idx, outlet in enumerate(outlets, start=len(data)+4):
    ws_ticket.append([
        outlet,
        f'=COUNTIFS(D2:D{len(data)+1}, A{idx}, F2:F{len(data)+1}, TRUE)',
        f'=COUNTIFS(D2:D{len(data)+1}, A{idx}, G2:G{len(data)+1}, TRUE)'
    ])

# ------------------ SHEET 2: FEEDBACKS ------------------
ws_feedbacks = wb.create_sheet("feedbacks")

ws_feedbacks.append([
    "cms_id", "feedback_at", "feedback_rating", "ticket_created_at"
])

feedback_data = [
    ["cms-001", "2021-08-19 13:00:00", 4],
    ["cms-002", "2021-08-20 10:00:00", 3],
    ["cms-003", "2021-08-20 12:00:00", 5],
    ["cms-004", "2021-08-20 16:00:00", 2],
    ["cms-005", "2021-08-21 10:00:00", 4],
]

for i, row in enumerate(feedback_data, start=2):
    ws_feedbacks.append(row + [
        f'=INDEX(ticket!B:B, MATCH(A{i}, ticket!E:E, 0))'
    ])

# save file
wb.save("Spreadsheets/Ticket_Analysis_Advanced.xlsx")

print("✅ File created: Ticket_Analysis_Advanced.xlsx")