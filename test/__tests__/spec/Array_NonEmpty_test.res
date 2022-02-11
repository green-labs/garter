open Zora

open Garter.Array.NonEmpty

let testEqual = (t, name, lhs, rhs) =>
  t->test(name, t => {
    t->equal(lhs, rhs, name)

    done()
  })

zoraBlock("fromArray", t => {
  t->testEqual("Empty", fromArray([]), None)
  t->testEqual("NonEmpty", fromArray([1, 2, 3]), Some(NonEmptyArray([1, 2, 3])))
})

zoraBlock("toArray", t => {
  t->testEqual("NonEmpty", toArray(NonEmptyArray([1, 2, 3])), [1, 2, 3])
})

zoraBlock("first", t => {
  t->testEqual("1", first(NonEmptyArray([1])), 1)
  t->testEqual("2", first(NonEmptyArray([1, 2, 3])), 1)
})

zoraBlock("last", t => {
  t->testEqual("1", last(NonEmptyArray([1])), 1)
  t->testEqual("2", last(NonEmptyArray([1, 2, 3, 4, 5])), 5)
})

zoraBlock("take", t => {
  t->testEqual("1", take(NonEmptyArray([1, 2, 3, 4, 5]), -1), [])
  t->testEqual("2", take(NonEmptyArray([1, 2, 3, 4, 5]), 2), [1, 2])
  t->testEqual("3", take(NonEmptyArray([1, 2, 3, 4, 5]), 7), [1, 2, 3, 4, 5])
})
