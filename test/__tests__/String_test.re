open Jest;
open Expect;

open Garter.String;

let testEqual = (name, lhs, rhs) => {
  test(name, () =>
    expect(lhs) |> toEqual(rhs)
  );
};

describe("pad", () => {
  testEqual("padEnd", "foo  ", "foo"->padEnd(5));
  testEqual("padEndWith", "foo..", "foo"->padEndWith(5, "."));

  testEqual("padStart", "  foo", "foo"->padStart(5));
  testEqual("padStartWith", "..foo", "foo"->padStartWith(5, "."));
});

describe("trim", () => {
  testEqual("trimEnd", "  foo", "  foo  "->trimEnd);
  testEqual("trimStart", "foo  ", "  foo  "->trimStart);
});
