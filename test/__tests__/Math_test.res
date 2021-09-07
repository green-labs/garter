open Garter.Math

let testEqual = (lhs, rhs) => {
  assert (lhs == rhs)
}

let lower = 0.5
let upper = 1.15

// lower bounded
assert (clamp_float(0., ~lower, ~upper) == lower)

// upper bounded
assert (clamp_float(10., ~lower, ~upper) == upper)

// in bound
assert (clamp_float(1., ~lower, ~upper) == 1.0)

// if any argument is NaN, return NaN
assert (clamp_float(0., ~lower=Js.Float._NaN, ~upper)->Js.Float.isNaN)
assert (clamp_float(0., ~lower=Js.Float._NaN, ~upper=Js.Float._NaN)->Js.Float.isNaN)
assert (clamp_float(Js.Float._NaN, ~lower, ~upper)->Js.Float.isNaN)
