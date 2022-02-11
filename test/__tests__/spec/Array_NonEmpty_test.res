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
