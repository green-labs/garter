include Js.Math;

let sum_int = Belt.Array.reduce(_, 0, (+));

let sum_float = Belt.Array.reduce(_, 0., (+.));

let average_int = nums => {
  nums->Belt.Array.length == 0
    ? 0.
    : sum_int(nums)->float_of_int /. nums->Belt.Array.length->float_of_int;
};

let average_float = nums => {
  nums->Belt.Array.length == 0
    ? 0. : sum_float(nums) /. nums->Belt.Array.length->float_of_int;
};
