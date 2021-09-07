include module type of Js.Math

let sum_int: array<int> => int
let sum_float: array<float> => float

let average_int: array<int> => float
let average_float: array<float> => float

/**
 * TC39 Math extension
 * https://rwaldron.github.io/proposal-math-extensions/#sec-math.clamp
 */
let clamp_int: (int, ~lower: int, ~upper: int) => int
let clamp_float: (float, ~lower: float, ~upper: float) => float
