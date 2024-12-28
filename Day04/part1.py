# filename = "small1.txt"
filename = "input.txt"

matrix = [line.strip() for line in open(filename).readlines()]
size = (len(matrix), len(matrix[0]))
print(f"Matrix size: {size}")


def findxmas(x, y):
    def moves():
        yield 1, 0
        yield 1, 1
        yield 0, 1
        yield -1, 1
        yield -1, 0
        yield -1, -1
        yield 0, -1
        yield 1, -1

    count = 0
    s = "MAS"
    for dx, dy in moves():
        count += 1
        nx, ny = x, y
        for c in s:
            nx += dx
            ny += dy
            if not (0 <= nx < size[1] and 0 <= ny < size[0]):
                count -= 1
                break
            if matrix[ny][nx] != c:
                count -= 1
                break

    return count


count = 0
for y, line in enumerate(matrix):
    for x, c in enumerate(line):
        if c == "X":
            count += findxmas(x, y)
print(f"Part 1: {count}")
