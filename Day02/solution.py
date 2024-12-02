# filename = "small.txt"
filename = "input.txt"

file = open(filename)


def is_safe(nums, safe=1):
    last = nums[0]
    dir = (nums[0] - nums[1]) < 0  # True: asc
    for i, n in enumerate(nums[1:]):
        if n == last or ((last - n) < 0) != dir or abs(last - n) > 3:
            if safe:
                safe -= 1
                for j in range(i - 1, i + 2):
                    if is_safe(nums[:j] + nums[j + 1 :], 0):
                        return True
                return False
            else:
                return False
        last = n
    return True


count1 = 0
count2 = 0
for line in file:
    nums = [int(n) for n in line.split(" ")]
    if is_safe(nums, 0):
        count1 += 1
    if is_safe(nums, 1):
        count2 += 1

print(f"Part 1: {count1} reports are safe")
print(f"Part 2: {count2} reports are safe")
