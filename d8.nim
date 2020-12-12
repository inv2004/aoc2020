import strutils
import sequtils

var p = readFile("in8.txt").splitLines().mapIt(it.split()).mapIt((it[0], it[1].parseInt))

proc check(pp: seq[(string, int)], replace = -1): (bool, int) =
  var bs = newSeqWith(pp.len, true)
  var p = pp
  if replace >= 0:
    p[replace][0] = if p[replace][0] == "jmp": "nop" elif p[replace][0] == "nop": "jmp" else: p[replace][0]
  var acc = 0
  var i = 0
  while bs[i]:
    bs[i] = false
    case p[i][0]
    of "nop": i.inc()
    of "acc": acc.inc(p[i][1]); i.inc()
    of "jmp": i.inc(p[i][1])
    if i >= p.len:
      return (true, acc)
  return (false, acc)

echo check(p)[1]

for i in 0..<p.len:
  let res = check(p, i)
  if res[0]:
    echo res[1]
    break
