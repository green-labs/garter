include Js.Math

let sum_int = Belt.Array.reduce(_, 0, (s, x) => s + x)

let sum_float = Belt.Array.reduce(_, 0., (s, x) => s +. x)

let average_int = nums => {
  sum_int(nums)->Int.toFloat /. nums->Belt.Array.length->Int.toFloat
}

let average_float = nums => {
  sum_float(nums) /. nums->Belt.Array.length->Int.toFloat
}

let clamp_int = (x, ~lower, ~upper) => {
  min_int(max_int(x, lower), upper)
}

let clamp_float = (x, ~lower, ~upper) => {
  min_float(max_float(x, lower), upper)
}
