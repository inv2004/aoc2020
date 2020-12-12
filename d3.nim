import strformat
import sequtils

proc traverse(step, down: int): int =
  var len = 0
  var i = 0
  var first = true

  var skip = down

  for l in lines("in3.txt"):
    if first:
      len = l.len
      first = false
      continue

    if skip > 1:
      skip.dec()
      continue

    if l[step*(i+1) mod len] == '#':
      result.inc()
    i.inc()

    skip = down

echo traverse(3, 1)

echo [(1,1), (3,1) ,(5,1), (7,1), (1,2)].mapIt(traverse(it[0], it[1])).foldl(a*b)
