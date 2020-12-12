import sequtils
import algorithm
import strutils

proc findX(s: string, init: (int, int)): int =
  var r = init
  for x in s:
    if x in "FL":
      r[1] = r[0] + (r[1]-r[0]) div 2
    else:
      r[0] = r[0] + (r[1]-r[0]) div 2
  r[0]

proc findRow(s: string): int =
  findX(s[0..<7], (0, 128))

proc findCol(s: string): int =
  findX(s[7..^1], (0, 8))

proc find(s: string): int =
  findX(s[0..<7], (0, 128)) * 8 + findX(s[7..^1], (0, 8))

echo toSeq(lines("in5.txt")).mapIt(findRow(it) * 8 + findCol(it)).max()

var m = newString(128 * 8)

for x in lines("in5.txt"):
  m[find(x)] = '1'

echo 1 + m.find("1\x001")
