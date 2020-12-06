def cbin(s, c):
    v, i = 0, 0
    m = len(s) - 1
    while i < len(s):
        if s[i] == c:
            v |= 1 << (m - i)
        i += 1
    return v

ids = []
with open("aoc5.txt") as f:
    for line in f:
        row = cbin(line[:7], "B")
        col = cbin(line.strip()[7:], "R")
        ids.append(row * 8 + col)

ids = sorted(ids)
print(ids)

last = ids[0]-1
for v in ids:
    if last != v - 1:
        print(v-1)
    last = v
