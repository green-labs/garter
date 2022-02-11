include module type of Belt_Array

let isEmpty: array<'a> => bool

let firstUnsafe: array<'a> => 'a
let firstExn: array<'a> => 'a
let first: array<'a> => option<'a>

let lastUnsafe: array<'a> => 'a
let lastExn: array<'a> => 'a
let last: array<'a> => option<'a>

@ocaml.doc("
0번째 인덱스부터 최대 n개의 원소를 반환합니다.
n이 음수라면 빈 배열을 반환합니다.
")
let take: (Js.Array2.t<'a>, int) => Js.Array2.t<'a>
let takeWhileU: (Js.Array2.t<'a>, (. 'a) => bool) => Js.Array2.t<'a>
let takeWhile: (Js.Array2.t<'a>, 'a => bool) => Js.Array2.t<'a>

@ocaml.doc("
0번째 인덱스부터 n개를 제외한 원소들의 배열을 반환합니다.
n이 배열의 크기보다 크면 빈 배열 반환합니다.
")
let drop: (Js.Array2.t<'a>, int) => Js.Array2.t<'a>
let dropWhileU: (Js.Array2.t<'a>, (. 'a) => bool) => Js.Array2.t<'a>
let dropWhile: (Js.Array2.t<'a>, 'a => bool) => Js.Array2.t<'a>

@ocaml.doc("
[i]번째 인덱스의 값에 [f]를 수행한 결과를 in-place로 업데이트합니다.
[f]는 old value를 받아 new value를 반환하는 함수입니다.
")
let updateUnsafeU: (array<'a>, int, (. 'a) => 'a) => unit
let updateUnsafe: (array<'a>, int, 'a => 'a) => unit
let updateExnU: (array<'a>, int, (. 'a) => 'a) => unit
let updateExn: (array<'a>, int, 'a => 'a) => unit

@ocaml.doc("
option타입의 배열에서 None을 제거하고, Some의 값을 꺼낸 결과의 배열을 반환합니다.
시간 복잡도: O(n)

{[
keepSome([ Some(1), None, Some(3) ]) == [ 1, 3 ]
]}
")
let keepSome: array<option<'a>> => array<'a>

@ocaml.doc("
keyFn으로 그루핑된 Belt.Map을 반환합니다.
~id에는 Belt.Id.Comparable 모듈이 전달되어야 합니다.
일반적인 타입에 대한 Comparable 모듈은 Garter.Id를 참고하세요.

{[
groupBy(
  [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ],
  x => x mod 3,
  ~id=Garter.Id.IntComparable,
)
]}
")
let groupBy: (array<'a>, 'a => 'b, ~id: Belt.Map.id<'b, 'c>) => Belt.Map.t<'b, array<'a>, 'c>

@ocaml.doc("
indexFn의 결과값을 Belt.Map의 key로 할당한 값을 반환합니다.
indexFn의 결과값이 중복되면 마지막으로 나온 값이 할당됩니다.

{[
type t = {a:int, b:int}
indexBy(
  [ {a:1, b:1}, {a:1, b:2}, {a:2, b:2}, {a:3, b:3} ],
  keyFn=x => x.a,
  ~id=Garter.Id.IntComparable,
)
// (1, {a:1, b:2}), (2, {a:2, b:2}), (3, {a:3, b:3})
]}
")
let indexBy: (array<'a>, 'a => 'b, ~id: Belt.Map.id<'b, 'c>) => Belt.Map.t<'b, 'a, 'c>

@ocaml.doc("
배열에 들어있는 값들의 빈도를 구하여 Map으로 반환합니다.
")
let frequencies: (array<'a>, ~id: Belt.Map.id<'a, 'b>) => Belt.Map.t<'a, int, 'b>

@ocaml.doc("
먼저 등장하는 순서를 유지하면서 중복 원소를 제거합니다.
")
let distinct: (array<'a>, ~id: Belt.Set.id<'a, 'b>) => array<'a>

@ocaml.doc("
reduce와 비슷하나 중간 결과를 모두 포함한 array를 반환합니다.
")
let scan: (array<'a>, 'b, ('b, 'a) => 'b) => array<'b>

let reduce1U: (array<'a>, (. 'a, 'a) => 'a) => 'a
let reduce1: (array<'a>, ('a, 'a) => 'a) => 'a

let minByU: (array<'a>, (. 'a, 'a) => int) => 'a
let minBy: (array<'a>, ('a, 'a) => int) => 'a

let maxByU: (array<'a>, (. 'a, 'a) => int) => 'a
let maxBy: (array<'a>, ('a, 'a) => int) => 'a

@ocaml.doc("
배열을 일정 크기로 자른 2차원 배열을 반환합니다.

{[
chunk([ 1, 2, 3, 4 ], 2)    // -> [ [ 1, 2 ], [ 3, 4 ] ]
chunk([ 1, 2, 3, 4, 5 ], 2) // -> [ [ 1, 2 ], [ 3, 4 ], [ 5 ] ]
chunk([ 1, 2, 3, 4, 5 ], 6) // -> [ [ 1, 2, 3, 4, 5 ] ]
]}
")
let chunk: (array<'a>, int) => array<array<'a>>

@ocaml.doc("
임의의 원소 1개를 무작위로 추출합니다.
참고:  https://clojuredocs.org/clojure.core/rand-nth

{[randomOne([#ice-cream, #steak, #apple]) // -> #apple]}
")
let randomOne: array<'a> => option<'a>

@ocaml.doc("
주어진 확률로 원소를 채택한 결과를 반환합니다.
참고: https://clojuredocs.org/clojure.core/random-sample

{[randomSample([1, 2, 3, 4, 5], 0.5) // -> [1, 2, 4]]}
")
let randomSample: (array<'a>, float) => array<'a>

@ocaml.doc("
두 번째 인자를 배열의 사이사이에 끼워넣은 결과를 반환합니다.

{[intersperse([1, 2, 3], 0) // -> [1, 0, 2, 0, 3]]}
")
let intersperse: (array<'a>, 'a) => array<'a>

module Int: {
  let groupBy: (array<'a>, 'a => Belt.Map.Int.key) => Belt.Map.Int.t<array<'a>>
  let indexBy: (array<'a>, 'a => Belt.Map.Int.key) => Belt.Map.Int.t<'a>
}

module String: {
  let groupBy: (array<'a>, 'a => Belt.Map.String.key) => Belt.Map.String.t<array<'a>>
  let indexBy: (array<'a>, 'a => Belt.Map.String.key) => Belt.Map.String.t<'a>
}

module NonEmpty: {
  type t<'a> = NonEmptyArray(array<'a>)

  let fromArray: array<'a> => option<t<'a>>
  let toArray: t<'a> => array<'a>
  let first: t<'a> => 'a
  let last: t<'a> => 'a
  let take: (t<'a>, int) => array<'a>
  let takeWhileU: (t<'a>, (. 'a) => bool) => array<'a>
  let takeWhile: (t<'a>, 'a => bool) => array<'a>
}
