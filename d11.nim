import strutils
import sequtils
import math


proc `$`(x: seq[string]): string =
  "\n" & x.join("\n")

proc busy(cs: openArray[char]): int =
  for s, c in cs:
    if c == '#' and s != 4:
      result += 1

proc free(cs: openArray[char]): int =
  for s, c in cs:
    if (c == 'L' or c == '.') and s != 4:
      result += 1

proc seats1(m: seq[string], s, j: int): string =
  for x in s-1..s+1:
   for y in j-1..j+1:
     result.add m[x][y]

proc getDirection(m: seq[string], i, j, i2, j2: int): char =
  let m0 = m[0]
  var ii = i + i2
  var jj = j + j2
  while ii in m.low..m.high and jj in m0.low..m0.high:
    result = m[ii][jj]
    if result != '.':
      return
    ii += i2
    jj += j2

proc seats2(m: seq[string], i, j: int): string =
  result = repeat('.', 9)

  result[0] = m.getDirection(i, j, -1, -1)
  result[1] = m.getDirection(i, j, -1, 0)
  result[2] = m.getDirection(i, j, -1, +1)
  result[3] = m.getDirection(i, j, 0, -1)
  result[4] = m[i][j]
  result[5] = m.getDirection(i, j, 0, +1)
  result[6] = m.getDirection(i, j, +1, -1)
  result[7] = m.getDirection(i, j, +1, 0)
  result[8] = m.getDirection(i, j, +1, +1)

proc step(mIn: var seq[string], f: proc (m: seq[string], i, j: int): string): bool =
  var m = mIn
  for s in 1..mIn.high-1:
    for j in 1..mIn[s].high-1:
      let ss = f(mIn, s, j)
      if ss[4] == 'L' and ss.free() == 8:
        m[s][j] = '#'
      elif ss[4] == '#' and ss.busy() >= 5:
        m[s][j] = 'L'

  result = m == mIn
  mIn = m

var m = toSeq(lines("in11.txt"))
m = repeat('.', 2+m[0].len) & m.mapIt("." & it & ".") & repeat('.', 2+m[0].len)
m.applyIt(it.replace("L", "#"))
while not step(m, seats1):
  discard

echo m.mapIt(it.count('#')).sum()

m = toSeq(lines("in11.txt"))
m = repeat('.', 2+m[0].len) & m.mapIt("." & it & ".") & repeat('.', 2+m[0].len)
m.applyIt(it.replace("L", "#"))
while not step(m, seats2):
  discard

echo m.mapIt(it.count('#')).sum()

