import strutils
import sequtils

var result = 0

for l in lines("in2.txt"):
  let f = l.split()
  let r = f[0].split("-").mapIt(it.parseInt())
  let c = count(f[2], f[1][0].char)
  if c in (r[0]..r[1]):
    result.inc()

echo result
result = 0

for l in lines("in2.txt"):
  let f = l.split()
  let r = f[0].split("-").mapIt(it.parseInt())
  if f[2][r[0]-1] == f[1][0] xor f[2][r[1]-1] == f[1][0]:
    result.inc()

echo result
