# filename = "small2.txt"
filename = "input.txt"

matrix = [line.strip() for line in open(filename).readlines()]
size = (len(matrix), len(matrix[0]))
print(f"Matrix size: {size}")


def isxmas(x, y):
    chars = [
        matrix[y - 1][x - 1],
        matrix[y - 1][x + 1],
        matrix[y + 1][x + 1],
        matrix[y + 1][x - 1],
    ]
    for i in range(4):
        chars = [*chars[1:], chars[0]]
        # print(f"{x} {y} {chars}")
        if chars == ["M", "S", "S", "M"]:
            # print(f"match {x} {y} {chars}")
            return 1
    return 0


count = 0
for y, line in enumerate(matrix[1:-1]):
    for x, c in enumerate(line[1:-1]):
        if c == "A":
            count += isxmas(x + 1, y + 1)

print(f"Part 2: {count}")
