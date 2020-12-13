import re

data = dict()
re_contained = re.compile(r"(\d+) ([a-z ]+) bags?")
with open("aoc7.txt") as f:
    for line in f:
        idx = line.find("bags contain")
        container = line[:idx-1]
        rest = line[idx+13:]
        if rest.startswith("no other bags"):
            contained = []
        else:
            contained = [re_contained.match(part.strip()) for part in rest.split(',')]
        data[container] = [(m.group(2), int(m.group(1))) for m in contained]

cache = {}
def contains(t):
    if t in cache:
        return cache[t]

    cache[t] = 0
    for name, quantity in data[t]:
        cache[t] += quantity + quantity*contains(name)

    return cache[t]

print(contains("shiny gold"))

