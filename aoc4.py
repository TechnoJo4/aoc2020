import re

required = {"byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"}

r = re.compile(r"([^ ]+):([^ ]+)")
passports = [dict()]
with open("aoc4.txt") as f:
    idx = 0
    for line in f:
        line = line.strip()
        if line == "":
            idx += 1
            passports.append(dict())
            continue

        for m in r.finditer(line):
            passports[idx][m.group(1)] = m.group(2)

year = re.compile(r"\d{4}")
height = re.compile(r"(\d+)(cm|in)")
hexcolor = re.compile(r"#[0-9a-f]{6}")
passid = re.compile(r"\d{9}")

allowed_ecl = {"amb", "blu", "brn", "gry", "grn", "hzl", "oth"}

c = 0
for p in passports:
    valid = True
    for req in required:
        if not req in p:
            valid = False
            break
    if not valid: continue

    byr = year.fullmatch(p["byr"])
    if not (byr and 1920 <= int(byr.group(0)) <= 2002): continue
    iyr = year.fullmatch(p["iyr"])
    if not (iyr and 2010 <= int(iyr.group(0)) <= 2020): continue
    eyr = year.fullmatch(p["eyr"])
    if not (eyr and 2020 <= int(eyr.group(0)) <= 2030): continue

    hgt = height.fullmatch(p["hgt"])
    if not (hgt and ({
            "cm": lambda v: 150 <= v <= 193,
            "in": lambda v: 59 <= v <= 76
        })[hgt.group(2)](int(hgt.group(1)))): continue

    if not hexcolor.fullmatch(p["hcl"]): continue
    if p["ecl"] not in allowed_ecl: continue
    if not passid.fullmatch(p["pid"]): continue

    c += 1

print(c)
