from itertools import combinations

with open("aoc1.txt") as f:
    for a,b in combinations([int(line) for line in f], 2):
        if a+b == 2020:
            print(a*b)
