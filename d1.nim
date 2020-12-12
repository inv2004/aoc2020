import sequtils
import strutils

let n = toSeq(lines("in1.txt")).map(parseInt)

block found:
  for i, a in n:
    for b in n[i..^1]:
      if a+b == 2020:
        echo a*b
        break found

block found:
  for i, a in n:
    for j, b in n[i..^1]:
      for c in n[j..^1]:
        if a+b+c == 2020:
          echo a*b*c
          break found

