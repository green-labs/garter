open Zora

let testEqual = (t, name, lhs, rhs) =>
  t->test(name, t => {
    t->equal(lhs, rhs, name)

    done()
  })

zoraBlock("fromKV", t => t->testEqual("1", Garter.Object.fromKV("a", 1), {"a": 1}))

let roundtrip = (o: {..}) => {
  Js.Json.stringifyAny(o)->Belt.Option.map(Js.Json.parseExn)->Belt.Option.getUnsafe
}

zoraBlock("toJsonUnsafe", t => {
  t->test("safe", t => {
    t->equal(
      Garter.Object.toJsonUnsafe({"x": 0}),
      Js.Json.object_(Js.Dict.fromArray([("x", Js.Json.number(0.0))])),
      "dict",
    )
    done()
  })

  t->test("unsafe", t => {
    let o = {"x": () => 1}
    t->notEqual(Garter.Object.toJsonUnsafe(o), roundtrip(o), "function")

    done()
  })
})

zoraBlock("[Object] toJsonExn", t => {
  t->test("dict", t => {
    t->equal(
      Garter.Object.toJsonExn({"x": 0}),
      Js.Json.object_(Js.Dict.fromArray([("x", Js.Json.number(0.0))])),
      "",
    )
    done()
  })

  t->test("roundtrip", t => {
    let o = {"x": () => 1}
    t->equal(Garter.Object.toJsonExn(o), roundtrip(o), "roundtrip")

    done()
  })
})

zoraBlock("[Object] toJson", t => {
  t->test("dict", t => {
    t->equal(
      Garter.Object.toJson({"x": 0}),
      Some(Js.Json.object_(Js.Dict.fromArray([("x", Js.Json.number(0.0))]))),
      "",
    )
    done()
  })

  t->test("roundtrip", t => {
    let o = {"x": () => 1}
    t->equal(Garter.Object.toJson(o), Some(roundtrip(o)), "roundtrip")

    done()
  })
})
