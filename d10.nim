import strutils, sequtils, algorithm, tables

proc prep(xs: seq[int]): seq[int] =
  @[0] & xs.sorted & xs.max + 3

var cache = newTable[int, int]()

proc calc(xs: seq[int]): int =
  var count = [0, 0, 0, 0]
  for (a,b) in xs[1..^1].zip(xs[0..^2]):
    count[a-b] += 1

  count[1] * count[3]

echo calc toSeq(lines("in10.txt")).map(parseInt).prep()

proc perm(xs: seq[int], clear = true): int =
  if clear:
    cache.clear()
  if xs.len == 1:
    return 1
  for i in 1..min(3, xs.len-1):
    if xs[i] - xs[0] in 1..3:
      let k = xs.len - i
      if k in cache:
        result += cache[k]
      else:
        cache[k] = perm(xs[i..^1], false)
        result += cache[k]

# echo perm @[3, 1, 6, 2].prep()
# echo perm @[4,11,7,8,1,6,5].prep()
# echo perm @[10, 6, 4, 7, 1, 5].prep()
# echo perm @[16, 10, 15, 5, 1, 11, 7, 19, 6, 12, 4].prep()
# echo perm @[28, 33, 18, 42, 31, 14, 46, 20, 48, 47, 24, 23, 49, 45, 19, 38, 39, 11, 1, 32, 25, 35, 8, 17, 7, 9, 4, 2, 34, 10, 3].prep()
echo perm toSeq(lines("in10.txt")).map(parseInt).prep()

