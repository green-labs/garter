open Zora

open Garter.Array.NonEmpty

let testEqual = (t, name, lhs, rhs) =>
  t->test(name, t => {
    t->equal(lhs, rhs, name)

    done()
  })

let emptyArray: option<Garter.Array.NonEmpty.t<int>> = []->fromArray
let nonEmptyArray = [1, 2, 3, 4, 5]->fromArray

zoraBlock("fromArray", t => {
  t->testEqual("Empty", fromArray([]), None)
})

zoraBlock("toArray", t => {
  t->testEqual("Empty", emptyArray->Belt.Option.map(toArray), None)
  t->testEqual("NonEmpty", nonEmptyArray->Belt.Option.map(toArray), Some([1, 2, 3, 4, 5]))
})

zoraBlock("first", t => {
  t->testEqual("Empty", emptyArray->Belt.Option.map(first), None)
  t->testEqual("NonEmpty", nonEmptyArray->Belt.Option.map(first), Some(1))
})

zoraBlock("last", t => {
  t->testEqual("Empty", emptyArray->Belt.Option.map(last), None)
  t->testEqual("NonEmpty", nonEmptyArray->Belt.Option.map(last), Some(5))
})

zoraBlock("take", t => {
  t->testEqual("1", nonEmptyArray->Belt.Option.map(ar => take(ar, -1)), Some([]))
  t->testEqual("2", nonEmptyArray->Belt.Option.map(ar => take(ar, 2)), Some([1, 2]))
  t->testEqual("3", nonEmptyArray->Belt.Option.map(ar => take(ar, 7)), Some([1, 2, 3, 4, 5]))
})
