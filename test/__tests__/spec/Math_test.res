open Zora

open Garter.Math

let testEqual = (lhs, rhs) => {
  assert(lhs == rhs)
}

zoraBlock("average", t => {
  t->ok(average_int([])->Float.isNaN, ~msg="average of no numbers")
  t->ok(average_float([])->Float.isNaN, ~msg="average of no numbers")
})

zoraBlock("clamp", t => {
  let lower = 0.5
  let upper = 1.15

  t->equal(clamp_float(0., ~lower, ~upper), lower, ~msg="lower bounded")

  t->equal(clamp_float(10., ~lower, ~upper), upper, ~msg="upper bounded")

  t->equal(clamp_float(1., ~lower, ~upper), 1.0, ~msg="in bound")

  // if any argument is NaN, return NaN
  t->ok(clamp_float(0., ~lower=Float.Constants.nan, ~upper)->Float.isNaN, ~msg="")
  t->ok(
    clamp_float(0., ~lower=Float.Constants.nan, ~upper=Float.Constants.nan)->Float.isNaN,
    ~msg="",
  )
  t->ok(clamp_float(Float.Constants.nan, ~lower, ~upper)->Float.isNaN, ~msg="")
})
