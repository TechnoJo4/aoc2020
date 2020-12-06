import re

valid = 0
regex = re.compile("(\\d+)-(\\d+) (.): (.+)")
with open("aoc2.txt") as f:
    for line in f:
        m = regex.match(line)
        if not m: print(line)

        cmin, cmax, char, pwd = m.group(1, 2, 3, 4)
        if int(cmin) <= len([c for c in pwd if c == char]) <= int(cmax):
            print("good",line)
            valid += 1

print(valid)
