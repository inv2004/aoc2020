import sequtils
import strutils

let cs = toSeq(lines("in12.txt")).mapIt((it[0], parseInt it[1..^1]))

proc go(cs: seq[(char, int)]): int =
  var x, y = 0
  var d = 1
  for (c, i) in cs:
    case c
    of 'F':
      case d
      of 0:   y += i
      of 1: x += i
      of 2: y -= i
      of 3: x -= i
      else:
        discard
    of 'L':
      d -= i div 90
      while d < 0:
        d = 4 + d
    of 'R':
      d += i div 90
      if d > 3:
        d = d mod 4
    of 'N':
      y += i
    of 'S':
      y -= i
    of 'E':
      x += i
    of 'W':
      x -= i
    else:
      discard

  x.abs + y.abs

proc rotate(wx, wy: var int, d: int, m = 1) =
  let c = m * d div 90
  for _ in 1..c:
    let z = wy
    wy = -wx
    wx = z

proc go2(cs: seq[(char, int)]): int =
  var x, y = 0
  var wx = 10
  var wy = 1
  for (c, i) in cs:
    case c
    of 'N', 'S':
      wy -= i * c.byte.cmp(80)
    of 'E', 'W':
      wx -= i * c.byte.cmp(80)
    of 'F':
      x += wx * i
      y += wy * i
    of 'R':
      rotate(wx, wy, i)
    of 'L':
      rotate(wx, wy, i, m = 3)
    else:
      discard

  x.abs + y.abs

echo go(cs)
echo go2(cs)
