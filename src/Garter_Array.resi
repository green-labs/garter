include module type of Belt_Array

let isEmpty: array<'a> => bool

let firstUnsafe: array<'a> => 'a
let firstExn: array<'a> => 'a
let first: array<'a> => option<'a>

let lastUnsafe: array<'a> => 'a
let lastExn: array<'a> => 'a
let last: array<'a> => option<'a>

/**
0번째 인덱스부터 최대 n개의 원소를 반환합니다.  
n이 음수라면 빈 배열을 반환합니다.
*/
let take: (array<'a>, int) => array<'a>
let takeWhile: (array<'a>, 'a => bool) => array<'a>

/**
0번째 인덱스부터 n개를 제외한 원소들의 배열을 반환합니다.  
n이 배열의 크기보다 크면 빈 배열 반환합니다.
*/
let drop: (array<'a>, int) => array<'a>
let dropWhile: (array<'a>, 'a => bool) => array<'a>

/**
[i]번째 인덱스의 값에 [f]를 수행한 결과를 in-place로 업데이트합니다.  
[f]는 old value를 받아 new value를 반환하는 함수입니다.
*/
let updateUnsafe: (array<'a>, int, 'a => 'a) => unit
let updateExn: (array<'a>, int, 'a => 'a) => unit

/**
`option`타입의 배열에서 `None`을 제거하고, `Some`의 값을 꺼낸 결과의 배열을 반환합니다.  
시간 복잡도: O(n)

```
keepSome([ Some(1), None, Some(3) ]) == [ 1, 3 ]
```
*/
let keepSome: array<option<'a>> => array<'a>

/**
`keyFn`으로 그루핑된 `Belt.Map`을 반환합니다.  
`~id`에는 `Belt.Id.Comparable` 모듈이 전달되어야 합니다.  
일반적인 타입에 대한 Comparable 모듈은 Garter.Id를 참고하세요.

```
groupBy(
  [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ],
  x => x mod 3,
  ~id=Garter.Id.IntComparable,
)
```
*/
let groupBy: (array<'a>, 'a => 'b, ~id: Belt.Map.id<'b, 'c>) => Belt.Map.t<'b, array<'a>, 'c>

/**
`indexFn`의 결과값을 `Belt.Map`의 `key`로 할당한 값을 반환합니다.  
`indexFn`의 결과값이 중복되면 마지막으로 나온 값이 할당됩니다.

```
type t = {a:int, b:int}
indexBy(
  [ {a:1, b:1}, {a:1, b:2}, {a:2, b:2}, {a:3, b:3} ],
  keyFn=x => x.a,
  ~id=Garter.Id.IntComparable,
)
// (1, {a:1, b:2}), (2, {a:2, b:2}), (3, {a:3, b:3})
```
*/
let indexBy: (array<'a>, 'a => 'b, ~id: Belt.Map.id<'b, 'c>) => Belt.Map.t<'b, 'a, 'c>

/**
배열에 들어있는 값들의 빈도를 구하여 `Map`으로 반환합니다.
*/
let frequencies: (array<'a>, ~id: Belt.Map.id<'a, 'b>) => Belt.Map.t<'a, int, 'b>

/**
먼저 등장하는 순서를 유지하면서 키에 따라 중복 원소를 제거합니다.
*/
let distinctBy: (array<'a>, 'a => 'b) => array<'a>

/**
먼저 등장하는 순서를 유지하면서 중복 원소를 제거합니다.
*/
let distinct: array<'a> => array<'a>

/**
`reduce`와 비슷하나 중간 결과를 모두 포함한 `array`를 반환합니다.
*/
let scan: (array<'a>, 'b, ('b, 'a) => 'b) => array<'b>

/**
배열을 일정 크기로 자른 2차원 배열을 반환합니다.

```
chunk([ 1, 2, 3, 4 ], 2)    // -> [ [ 1, 2 ], [ 3, 4 ] ]
chunk([ 1, 2, 3, 4, 5 ], 2) // -> [ [ 1, 2 ], [ 3, 4 ], [ 5 ] ]
chunk([ 1, 2, 3, 4, 5 ], 6) // -> [ [ 1, 2, 3, 4, 5 ] ]
```
*/
let chunk: (array<'a>, int) => array<array<'a>>

/**
임의의 원소 1개를 무작위로 추출합니다.  
참고:  https://clojuredocs.org/clojure.core/rand-nth

```
randomOne([#ice-cream, #steak, #apple]) // -> #apple
```
*/
let randomOne: array<'a> => option<'a>

/**
주어진 확률로 원소를 채택한 결과를 반환합니다.  
참고: https://clojuredocs.org/clojure.core/random-sample

```
randomSample([1, 2, 3, 4, 5], 0.5) // -> [1, 2, 4]
```
*/
let randomSample: (array<'a>, float) => array<'a>

/**
두 번째 인자를 배열의 사이사이에 끼워넣은 결과를 반환합니다.

```
intersperse([1, 2, 3], 0) // -> [1, 0, 2, 0, 3]
```
*/
let intersperse: (array<'a>, 'a) => array<'a>

module Int: {
  let groupBy: (array<'a>, 'a => Belt.Map.Int.key) => Belt.Map.Int.t<array<'a>>
  let indexBy: (array<'a>, 'a => Belt.Map.Int.key) => Belt.Map.Int.t<'a>
}

module String: {
  let joinWith: (array<string>, string) => string
  let groupBy: (array<'a>, 'a => Belt.Map.String.key) => Belt.Map.String.t<array<'a>>
  let indexBy: (array<'a>, 'a => Belt.Map.String.key) => Belt.Map.String.t<'a>
}

module NonEmpty: {
  type t<'a>

  let length: t<'a> => int

  let size: t<'a> => int

  let get: (t<'a>, int) => option<'a>
  let getExn: (t<'a>, int) => 'a
  let getUnsafe: (t<'a>, int) => 'a
  let getUndefined: (t<'a>, int) => undefined<'a>

  let set: (t<'a>, int, 'a) => bool
  let setExn: (t<'a>, int, 'a) => unit
  let setUnsafe: (t<'a>, int, 'a) => unit

  let shuffleInPlace: t<'a> => unit
  let shuffle: t<'a> => t<'a>

  let reverseInPlace: t<'a> => unit
  let reverse: t<'a> => t<'a>

  let zip: (t<'a>, t<'b>) => t<('a, 'b)>
  let zipBy: (t<'a>, t<'b>, ('a, 'b) => 'c) => t<'c>

  let unzip: t<('a, 'b)> => (t<'a>, t<'b>)

  let concat: (t<'a>, t<'a>) => t<'a>
  let concatMany: t<t<'a>> => t<'a>

  let slice: (t<'a>, ~offset: int, ~len: int) => array<'a>
  let sliceToEnd: (t<'a>, int) => array<'a>
  let copy: t<'a> => t<'a>

  let fill: (t<'a>, ~offset: int, ~len: int, 'a) => unit

  let blit: (~src: t<'a>, ~srcOffset: int, ~dst: array<'a>, ~dstOffset: int, ~len: int) => unit
  let blitUnsafe: (
    ~src: t<'a>,
    ~srcOffset: int,
    ~dst: array<'a>,
    ~dstOffset: int,
    ~len: int,
  ) => unit

  let forEach: (t<'a>, 'a => unit) => unit

  let map: (t<'a>, 'a => 'b) => t<'b>

  let getBy: (t<'a>, 'a => bool) => option<'a>

  let getIndexBy: (t<'a>, 'a => bool) => option<int>

  let keep: (t<'a>, 'a => bool) => array<'a>

  let keepWithIndex: (t<'a>, ('a, int) => bool) => array<'a>

  let keepMap: (t<'a>, 'a => option<'b>) => array<'b>

  let forEachWithIndex: (t<'a>, (int, 'a) => unit) => unit

  let mapWithIndex: (t<'a>, (int, 'a) => 'b) => t<'b>

  let partition: (t<'a>, 'a => bool) => (array<'a>, array<'a>)

  let reduce: (t<'b>, 'a, ('a, 'b) => 'a) => 'a

  let reduceReverse: (t<'b>, 'a, ('a, 'b) => 'a) => 'a

  let reduceReverse2: (t<'a>, t<'b>, 'c, ('c, 'a, 'b) => 'c) => 'c

  let reduceWithIndex: (t<'a>, 'b, ('b, 'a, int) => 'b) => 'b

  let joinWith: (t<'a>, string, 'a => string) => string

  let some: (t<'a>, 'a => bool) => bool

  let every: (t<'a>, 'a => bool) => bool

  let some2: (t<'a>, t<'b>, ('a, 'b) => bool) => bool

  let every2: (t<'a>, t<'b>, ('a, 'b) => bool) => bool

  let cmp: (t<'a>, t<'a>, ('a, 'a) => int) => int

  let eq: (t<'a>, t<'a>, ('a, 'a) => bool) => bool

  let truncateToLengthUnsafe: (t<'a>, int) => unit

  let fromArray: array<'a> => option<t<'a>>
  let fromArrayExn: array<'a> => t<'a>

  let toArray: t<'a> => array<'a>

  let first: t<'a> => 'a
  let last: t<'a> => 'a

  let reduce1: (t<'a>, ('a, 'a) => 'a) => 'a

  let minBy: (t<'a>, ('a, 'a) => int) => 'a

  let maxBy: (t<'a>, ('a, 'a) => int) => 'a

  let take: (t<'a>, int) => array<'a>
  let takeWhile: (t<'a>, 'a => bool) => array<'a>

  let drop: (t<'a>, int) => array<'a>
  let dropWhile: (t<'a>, 'a => bool) => array<'a>

  let updateUnsafe: (t<'a>, int, 'a => 'a) => unit
  let updateExn: (t<'a>, int, 'a => 'a) => unit

  let keepSome: t<option<'a>> => array<'a>

  let groupBy: (t<'a>, 'a => 'b, ~id: Belt.Map.id<'b, 'c>) => Belt.Map.t<'b, t<'a>, 'c>

  let indexBy: (t<'a>, 'a => 'b, ~id: Belt.Map.id<'b, 'c>) => Belt.Map.t<'b, 'a, 'c>

  let frequencies: (t<'a>, ~id: Belt.Map.id<'a, 'b>) => Belt.Map.t<'a, int, 'b>

  let distinct: t<'a> => t<'a>

  let distinctBy: (t<'a>, 'a => 'b) => t<'a>

  let scan: (t<'a>, 'b, ('b, 'a) => 'b) => t<'b>

  let chunk: (t<'a>, int) => t<array<'a>>

  let randomOne: t<'a> => 'a

  let randomSample: (t<'a>, float) => array<'a>

  let intersperse: (t<'a>, 'a) => t<'a>

  module Int: {
    let groupBy: (t<'a>, 'a => Belt.Map.Int.key) => Belt.Map.Int.t<t<'a>>
    let indexBy: (t<'a>, 'a => Belt.Map.Int.key) => Belt.Map.Int.t<'a>
  }

  module String: {
    let joinWith: (t<string>, string) => string
    let groupBy: (t<'a>, 'a => Belt.Map.String.key) => Belt.Map.String.t<t<'a>>
    let indexBy: (t<'a>, 'a => Belt.Map.String.key) => Belt.Map.String.t<'a>
  }
}
