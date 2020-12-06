import re

valid = 0
regex = re.compile("(\\d+)-(\\d+) (.): (.+)")
with open("aoc2.txt") as f:
    for line in f:
        m = regex.match(line)
        if not m: print(line)

        idx1, idx2, char, pwd = m.group(1, 2, 3, 4)
        if (pwd[int(idx1)-1] == char) ^ (pwd[int(idx2)-1] == char):
            print("good",line)
            valid += 1

print(valid)
