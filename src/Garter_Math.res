include Js.Math

let sum_int = Belt.Array.reduceU(_, 0, (. s, x) => s + x)

let sum_float = Belt.Array.reduceU(_, 0., (. s, x) => s +. x)

let average_int = nums => {
  nums->Belt.Array.length == 0
    ? 0.
    : sum_int(nums)->float_of_int /. nums->Belt.Array.length->float_of_int
}

let average_float = nums => {
  nums->Belt.Array.length == 0 ? 0. : sum_float(nums) /. nums->Belt.Array.length->float_of_int
}
