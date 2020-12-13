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
        data[container] = [(m.group(2), m.group(1)) for m in contained]

cache = {}
def contains(t):
    if t in cache:
        return cache[t]

    for name, _ in data[t]:
        if name == "shiny gold" or contains(name):
            cache[t] = True
            return True

    cache[t] = False
    return False

yes = [contains(t) for t in data]
print(len([v for v in yes if v]), yes)

