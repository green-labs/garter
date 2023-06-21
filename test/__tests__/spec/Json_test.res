open Zora

let testEqual = (t, name, lhs, rhs) =>
  t->test(name, async t => {
    t->equal(lhs, rhs, name)
  })

zoraBlock("[Json] stringifyExn", t => {
  t->test("object", async t => {
    t->equal(Garter.Json.stringifyExn({"x": 0}), Some(`{"x":0}`), "")
  })

  t->test("undefined", async t => {
    t->equal(Garter.Json.stringifyExn(Js.Undefined.empty), None, "")
  })
})

zoraBlock("[Json] stringify", t => {
  t->test("object", async t => {
    t->equal(Garter.Json.stringify({"x": 0}), Some(`{"x":0}`), "")
  })

  t->test("undefined", async t => {
    t->equal(Garter.Json.stringify(Js.Undefined.empty), None, "")
  })
})

zoraBlock("[Json] parse", t => {
  t->test("object", async t => {
    t->equal(
      Garter.Json.stringify({"x": 0})->Belt.Option.flatMap(Garter.Json.parse),
      Some(Js.Json.object_(Js.Dict.fromArray([("x", Js.Json.number(0.0))]))),
      "",
    )
  })

  t->test("undefined", async t => {
    t->equal(Garter.Json.parse(Obj.magic(Js.Undefined.empty)), None, "")
  })
})

let roundtrip = json => json->Garter.Json.stringify->Belt.Option.flatMap(Garter.Json.parse)

zoraBlock("[Json] roundtrip", t => {
  t->test("json", async t => {
    let json = Js.Json.object_(Js.Dict.fromArray([("x", Js.Json.number(0.0))]))
    t->equal(json->roundtrip, Some(json), "")
  })
})
