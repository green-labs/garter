include Belt.Array;

let isEmpty = xs => Belt.Array.length(xs) === 0;

/**
 * Updates in-place where `i` is an index and `f` is a function that will take the old value and return the new value.
 * No bounds checking.
 */
let updateUnsafeU = (ar, i, f) => {
  let v = Belt.Array.getUnsafe(ar, i);
  Belt.Array.setUnsafe(ar, i, f(. v));
};

let updateUnsafe = (ar, i, f) => {
  updateUnsafeU(ar, i, (. x) => f(x));
};

let updateExnU = (ar, i, f) => {
  let v = Belt.Array.getExn(ar, i);
  Belt.Array.setUnsafe(ar, i, f(. v));
};

let updateExn = (ar, i, f) => {
  updateExnU(ar, i, (. x) => f(x));
};
