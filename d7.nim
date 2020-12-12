import strutils except repeat
import sequtils
import tables
import math

var h = initTable[string, seq[(int, string)]]()

for l in lines("in7.txt"):
  let a = l.split("contain")
  if a[1] == " no other bags.":
    h[" " & a[0][0..^2].replace("bags", "bag")] = @[]
  else:
    h[" " & a[0][0..^2].replace("bags", "bag")] = a[1][0..^2].split(",").mapIt((it[1..1].parseInt(), it[2..^1].replace("bags", "bag")))

proc buildPath(x: seq[(int, string)]): seq[(int, string)] =
  var path = newSeq[(int, string)]()
  for v in x:
    if v[1] in h:
      path.add h[v[1]].mapIt((it[0] * v[0], it[1]))
  x & (if path.len > 0: buildPath(path) else: @[])

var result = 0

for k, v in h:
  if buildPath(v).anyIt(it[1] == " shiny gold bag"):
    result.inc()

echo result

echo buildPath(h[" shiny gold bag"]).mapIt(it[0]).sum()