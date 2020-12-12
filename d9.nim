import sequtils
import strutils

const p = 25

let xs = toSeq(lines("in9.txt")).map(parseInt)

proc find(): int =
  for i, x in xs[p..^1]:
    let pp = xs[i..<i+p]

    var found = false
    for y in pp:
      for z in pp.filterIt(it != y):
        if y+z == x:
          found = true
          break
    
    if not found:
      return x

let n = find()
echo n

var sum = 0
var a = 0
var b = 0
while true:
  if sum < n:
    sum += xs[b]
    b.inc()
  if sum > n:
    sum -= xs[a]
    a.inc()
  if sum == n:
    echo xs[a..b-1].min() + xs[a..b-1].max()
    break

