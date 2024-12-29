import bisect
import math

# filename = "small.txt"
filename = "input.txt"

file = open(filename)

rules = {}
for linenum, rule in enumerate(file.readlines()):
    rule = rule.strip()
    if len(rule) == 0:
        break
    a, b = rule.split("|")
    a, b = int(a), int(b)
    if not rules.get(a):
        rules[a] = []
    bisect.insort_left(rules[a], b)


def is_update_good(update):
    for i, n in enumerate(update):
        # numbers that can't be before this number according to the rules
        not_before = rules.get(n)
        if not_before:
            for j, m in enumerate(update[:i]):
                if m in not_before:  # TODO: optimize for ordered list
                    return False
    return True


sum = 0
file.seek(0)
updates = file.readlines()[linenum + 1 :]
unordered = []
for i, update in enumerate(updates):
    update = update.strip()
    nums = [int(n) for n in update.split(",")]
    is_good = is_update_good(nums)
    if is_good:
        sum += nums[math.floor(len(nums) / 2)]
    else:
        unordered.append(nums)

print(f"Part 1: {sum}")


def order(update):
    ordered = []
    for n in update:
        not_before = rules.get(n, [])
        inserted = False
        for j, m in enumerate(ordered):
            if m in not_before:
                ordered.insert(j, n)
                inserted = True
                break
        if not inserted:
            ordered.append(n)
    return ordered


sum = 0
for update in unordered:
    ordered = order(update)
    sum += ordered[math.floor(len(ordered) / 2)]
print(f"Part 2: {sum}")
