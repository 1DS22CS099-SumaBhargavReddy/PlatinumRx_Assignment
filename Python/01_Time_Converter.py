# 1) Given number of minutes, convert it into human readable form.
# Example :
# 130 becomes “2 hrs 10 minutes”
# 110 becomes “1hr 50minutes”

def convert_human(minutes):
    hours=minutes//60 # 2.11 -> 2
    remaining_min=minutes%60 # 10
    
    if hours==1:
        hours_label="hr"
    else:
        hours_label="hrs"
    return f"{hours} {hours_label} {remaining_min} minutes"
minutes=int(input("Enter the minutes: "))
print(convert_human(minutes))
print(convert_human(130))
print(convert_human(110))