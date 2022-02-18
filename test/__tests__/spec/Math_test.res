open Zora

open Garter.Math

let testEqual = (lhs, rhs) => {
  assert (lhs == rhs)
}

zoraBlock("average", t => {
  t->ok(average_int([])->Js.Float.isNaN, "average of no numbers")
  t->ok(average_float([])->Js.Float.isNaN, "average of no numbers")
})

zoraBlock("clamp", t => {
  let lower = 0.5
  let upper = 1.15

  t->equal(clamp_float(0., ~lower, ~upper), lower, "lower bounded")

  t->equal(clamp_float(10., ~lower, ~upper), upper, "upper bounded")

  t->equal(clamp_float(1., ~lower, ~upper), 1.0, "in bound")

  // if any argument is NaN, return NaN
  t->ok(clamp_float(0., ~lower=Js.Float._NaN, ~upper)->Js.Float.isNaN, "")
  t->ok(clamp_float(0., ~lower=Js.Float._NaN, ~upper=Js.Float._NaN)->Js.Float.isNaN, "")
  t->ok(clamp_float(Js.Float._NaN, ~lower, ~upper)->Js.Float.isNaN, "")
})
