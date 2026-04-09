# remove duplicates from a string using a loop
def remove_duplicates(input_string):
    result = ""
    for char in input_string:
        if char not in result:
            result += char
    return result

# testing the logic
input_string = input("Enter a string: ")
print(remove_duplicates(input_string))
print(remove_duplicates("hello world"))
print(remove_duplicates("programming"))
