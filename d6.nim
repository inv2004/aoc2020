import strutils
import sequtils
import math
import sets

echo readFile("in6.txt").split("\c\n\c\n").mapIt(it.replace("\r\n").deduplicate().len).sum()

echo readFile("in6.txt").split("\c\n\c\n").mapIt(it.split("\r\n").mapIt(it.toHashSet()).foldl(a * b).len()).sum()
