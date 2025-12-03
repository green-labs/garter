open Zora

let testEqual = (t, name, lhs, rhs) =>
  t->test(name, async t => {
    t->equal(lhs, rhs, ~msg=name)
  })

zoraBlock("fromKV", t => t->testEqual("1", Garter.Object.fromKV("a", 1), {"a": 1}))

let roundtrip = (o: {..}) => {
  JSON.stringifyAny(o)
  ->Belt.Option.map(json => JSON.parseOrThrow(json))
  ->Belt.Option.getUnsafe
}

zoraBlock("toJsonUnsafe", t => {
  t->test("safe", async t => {
    t->equal(
      Garter.Object.toJsonUnsafe({"x": 0}),
      JSON.Encode.object(Dict.fromArray([("x", JSON.Encode.float(0.0))])),
      ~msg="dict",
    )
  })

  t->test("unsafe", async t => {
    let o = {"x": () => 1}
    t->notEqual(Garter.Object.toJsonUnsafe(o), roundtrip(o), ~msg="function")
  })
})

zoraBlock("[Object] toJsonExn", t => {
  t->test("dict", async t => {
    t->equal(
      Garter.Object.toJsonExn({"x": 0}),
      JSON.Encode.object(Dict.fromArray([("x", JSON.Encode.float(0.0))])),
      ~msg="",
    )
  })

  t->test("roundtrip", async t => {
    let o = {"x": () => 1}
    t->equal(Garter.Object.toJsonExn(o), roundtrip(o), ~msg="roundtrip")
  })
})

zoraBlock("[Object] toJson", t => {
  t->test("dict", async t => {
    t->equal(
      Garter.Object.toJson({"x": 0}),
      Some(JSON.Encode.object(Dict.fromArray([("x", JSON.Encode.float(0.0))]))),
      ~msg="",
    )
  })

  t->test("roundtrip", async t => {
    let o = {"x": () => 1}
    t->equal(Garter.Object.toJson(o), Some(roundtrip(o)), ~msg="roundtrip")
  })
})
