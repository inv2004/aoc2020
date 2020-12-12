import sequtils
import strutils
import sets
import tables

const fs = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"].toHashSet

var result = 0

for pStr in readFile("in4.txt").split("\c\n\c\n"):
  let p =  pStr.replace("\c\n", " ").split().mapIt(it.split(":")).mapIt((it[0], it[1])).toTable
  let s = toHashSet(toSeq(p.keys))
  if s >= fs:
    if p["byr"].parseInt() notin (1920..2002): continue
    if p["iyr"].parseInt() notin (2010..2020): continue
    if p["eyr"].parseInt() notin (2020..2030): continue
    if p["hgt"].endsWith("cm"):
      if p["hgt"][0..^3].parseInt notin (150..193): continue
    elif p["hgt"].endsWith("in"):
      if p["hgt"][0..^3].parseInt notin (59..76): continue
    else:
      continue
    if not (p["hcl"][0] == '#' and p["hcl"][1..^1].allIt(it in {'0'..'9', 'a'..'z', 'A'..'Z'})):
      continue
    if p["ecl"] notin ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]:
      continue
    if not (p["pid"].len == 9 and p["pid"].allIt(it in {'0'..'9'})):
      continue

    result.inc()

echo result