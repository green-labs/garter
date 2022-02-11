open Zora

let testEqual = (t, name, lhs, rhs) =>
  t->test(name, t => {
    t->equal(lhs, rhs, name)

    done()
  })

zoraBlock("fromKV", t => t->testEqual("1", Garter.Object.fromKV("a", 1), {"a": 1}))
