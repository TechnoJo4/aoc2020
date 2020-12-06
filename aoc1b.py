from itertools import combinations

with open("aoc1.txt") as f:
    for a,b,c in combinations([int(line) for line in f], 3):
        if a+b+c == 2020:
            print(a*b*c)
