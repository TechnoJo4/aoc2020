groups = []
with open("aoc6.txt") as f:
    group = None
    for line in f:
        line = line.strip()
        if line == "":
            groups.append(len(group))
            group = None
            continue
        if group is None:
            group = set(line)
            continue

        group &= set(line)

    groups.append(len(group))

print(sum(groups))
