open Zora

let testEqual = (t, name, lhs, rhs) =>
  t->test(name, async t => {
    t->equal(lhs, rhs, ~msg=name)
  })

zoraBlock("[Json] stringifyExn", t => {
  t->test("object", async t => {
    t->equal(Garter.Json.stringifyExn({"x": 0}), Some(`{"x":0}`), ~msg="")
  })

  t->test("undefined", async t => {
    t->equal(Garter.Json.stringifyExn(Nullable.undefined), None, ~msg="")
  })
})

zoraBlock("[Json] stringify", t => {
  t->test("object", async t => {
    t->equal(Garter.Json.stringify({"x": 0}), Some(`{"x":0}`), ~msg="")
  })

  t->test("undefined", async t => {
    t->equal(Garter.Json.stringify(Nullable.undefined), None, ~msg="")
  })
})

zoraBlock("[Json] parse", t => {
  t->test("object", async t => {
    t->equal(
      Garter.Json.stringify({"x": 0})->Belt.Option.flatMap(Garter.Json.parse),
      Some(JSON.Encode.object(Dict.fromArray([("x", JSON.Encode.float(0.0))]))),
      ~msg="",
    )
  })

  t->test("undefined", async t => {
    t->equal(Garter.Json.parse(Obj.magic(Nullable.undefined)), None, ~msg="")
  })
})

let roundtrip = json => json->Garter.Json.stringify->Belt.Option.flatMap(Garter.Json.parse)

zoraBlock("[Json] roundtrip", t => {
  t->test("json", async t => {
    let json = JSON.Encode.object(Dict.fromArray([("x", JSON.Encode.float(0.0))]))
    t->equal(json->roundtrip, Some(json), ~msg="")
  })
})
