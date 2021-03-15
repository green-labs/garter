open Jest;
open Expect;

open Garter.Array;
open Garter.Fn;

let testEqual = (name, lhs, rhs) => {
  test(name, () =>
    expect(lhs) |> toEqual(rhs)
  );
};

describe("take", () => {
  testEqual("1", take([|1, 2, 3, 4, 5|], -1), [||]);
  testEqual("2", take([|1, 2, 3, 4, 5|], 2), [|1, 2|]);
  testEqual("3", take([|1, 2, 3, 4, 5|], 7), [|1, 2, 3, 4, 5|]);
});

describe("drop", () => {
  testEqual("1", drop([|1, 2, 3, 4, 5|], -1), [|1, 2, 3, 4, 5|]);
  testEqual("2", drop([|1, 2, 3, 4, 5|], 2), [|3, 4, 5|]);
  testEqual("3", drop([|1, 2, 3, 4, 5|], 7), [||]);
});

describe("takeWhile", () => {
  testEqual("1", takeWhile([|1, 2, 3, 4, 5|], x => x <= 2), [|1, 2|]);
  testEqual("2", takeWhile([|1, 2, 3, 4, 5|], constantly(false)), [||]);
});

describe("dropWhile", () => {
  testEqual("1", dropWhile([|1, 2, 3, 4, 5|], x => x <= 2), [|3, 4, 5|]);
  testEqual("2", dropWhile([|1, 2, 3, 4, 5|], constantly(true)), [||]);
});

describe("catOptions", () => {
  testEqual("1", catOptions([|Some(1), None, Some(3)|]), [|1, 3|])
});

describe("minBy", () => {
  testEqual("1", minBy([|1, 2, 3, 4, 5|], compare), 1);
  testEqual("2", minByU([|1, 2, 3, 4, 5|], (. a, b) => compare(a, b)), 1);
});

describe("maxBy", () => {
  testEqual("1", maxBy([|1, 2, 3, 4, 5|], compare), 5);
  testEqual("2", maxByU([|1, 2, 3, 4, 5|], (. a, b) => compare(a, b)), 5);
});
