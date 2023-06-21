open Zora

open Garter.Array
open! Garter.Array.NonEmpty

let testEqual = (t, name, lhs, rhs) =>
  t->test(name, async t => {
    t->equal(lhs, rhs, name)
  })

let emptyArray: option<Garter.Array.NonEmpty.t<int>> = []->fromArray
let nonEmptyArray = [1, 2, 3, 4, 5]->fromArrayExn

zoraBlock("fromArray", t => {
  t->testEqual("Empty", fromArray([]), None)
})

zoraBlock("toArray", t => {
  t->testEqual("Empty", emptyArray->Belt.Option.map(toArray), None)
  t->testEqual("NonEmpty", nonEmptyArray->toArray, [1, 2, 3, 4, 5])
})

zoraBlock("first", t => {
  t->testEqual("Empty", emptyArray->Belt.Option.map(first), None)
  t->testEqual("NonEmpty", nonEmptyArray->first, 1)
})

zoraBlock("last", t => {
  t->testEqual("Empty", emptyArray->Belt.Option.map(last), None)
  t->testEqual("NonEmpty", nonEmptyArray->last, 5)
})

zoraBlock("take", t => {
  t->testEqual("1", nonEmptyArray->take(-1), [])
  t->testEqual("2", nonEmptyArray->take(2), [1, 2])
  t->testEqual("3", nonEmptyArray->take(7), [1, 2, 3, 4, 5])
})

zoraBlock("reduce1", t => t->testEqual("", reduce1(range(1, 10)->fromArrayExn, \"+"), 55))

zoraBlock("minBy", t => {
  t->testEqual("1", minBy([1, 2, 3, 4, 5]->fromArrayExn, compare), 1)
})

zoraBlock("maxBy", t => {
  t->testEqual("1", maxBy([1, 2, 3, 4, 5]->fromArrayExn, compare), 5)
})

zoraBlock("concatMany", t => {
  let nonEmptyArrayArray = [nonEmptyArray, nonEmptyArray]->fromArrayExn
  t->testEqual("1", nonEmptyArrayArray->concatMany, [1, 2, 3, 4, 5, 1, 2, 3, 4, 5]->fromArrayExn)
})
