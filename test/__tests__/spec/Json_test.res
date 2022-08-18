open Zora

let testEqual = (t, name, lhs, rhs) =>
  t->test(name, t => {
    t->equal(lhs, rhs, name)

    done()
  })

zoraBlock("[Json] stringifyExn", t => {
  t->test("object", t => {
    t->equal(Garter.Json.stringifyExn({"x": 0}), Some(`{"x":0}`), "")
    done()
  })

  t->test("undefined", t => {
    t->equal(Garter.Json.stringifyExn(Js.Undefined.empty), None, "")
    done()
  })
})

zoraBlock("[Json] stringify", t => {
  t->test("object", t => {
    t->equal(Garter.Json.stringify({"x": 0}), Some(`{"x":0}`), "")
    done()
  })

  t->test("undefined", t => {
    t->equal(Garter.Json.stringify(Js.Undefined.empty), None, "")
    done()
  })
})

zoraBlock("[Json] parse", t => {
  t->test("object", t => {
    t->equal(
      Garter.Json.stringify({"x": 0})->Belt.Option.flatMap(Garter.Json.parse),
      Some(Js.Json.object_(Js.Dict.fromArray([("x", Js.Json.number(0.0))]))),
      "",
    )
    done()
  })

  t->test("undefined", t => {
    t->equal(Garter.Json.parse(Obj.magic(Js.Undefined.empty)), None, "")
    done()
  })
})

let roundtrip = json => json->Garter.Json.stringify->Belt.Option.flatMap(Garter.Json.parse)

zoraBlock("[Json] roundtrip", t => {
  t->test("json", t => {
    let json = Js.Json.object_(Js.Dict.fromArray([("x", Js.Json.number(0.0))]))
    t->equal(json->roundtrip, Some(json), "")
    done()
  })
})
