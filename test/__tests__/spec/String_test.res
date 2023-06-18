open Zora

open Garter.String

let testEqual = (t, name, lhs, rhs) =>
  t->test(name, async t => {
    t->equal(lhs, rhs, name)
  })

zoraBlock("pad", t => {
  t->testEqual("padEnd", "foo  ", "foo"->padEnd(5))
  t->testEqual("padEndWith", "foo..", "foo"->padEndWith(5, "."))

  t->testEqual("padStart", "  foo", "foo"->padStart(5))
  t->testEqual("padStartWith", "..foo", "foo"->padStartWith(5, "."))
})

zoraBlock("trim", t => {
  t->testEqual("trimEnd", "  foo", "  foo  "->trimEnd)
  t->testEqual("trimStart", "foo  ", "  foo  "->trimStart)
})
