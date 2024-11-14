module StringComparable = Belt.Id.MakeComparable({
  type t = string
  let cmp = (a, b) => Js.String2.localeCompare(a, b)->Float.toInt
})

module IntComparable = Belt.Id.MakeComparable({
  type t = int
  let cmp = (a, b) => a - b
})

module BigIntComparable = Belt.Id.MakeComparable({
  type t = bigint
  let cmp = (a, b) => BigInt.\"-"(a, b)->BigInt.toInt
})

// 정말 필요한 것인지 다시 생각해기
module FloatComparable = Belt.Id.MakeComparable({
  type t = float
  let cmp = (a, b) => Pervasives.compare(a, b)
})
