import re

# filename = "small.txt"
filename = "input.txt"

line = open(filename).read()

print("Part 1:", sum([int(a) * int(b) for a, b in re.findall(r"mul\((\d*?),(\d*?)\)", line, re.MULTILINE)]))

enabled = True
sum = 0
for a, b, do, dont in re.findall(r"mul\((\d*?),(\d*?)\)|(do\(\))|(don't\(\))", line, re.MULTILINE):
    if not do and not dont:
        if enabled:
            sum += int(a) * int(b)
    else:
        enabled = do != ""

print("Part 2:", sum)
