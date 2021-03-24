open Jest
open Expect

let testEqual = (name, lhs, rhs) => test(name, () => expect(lhs) |> toEqual(rhs))

describe("fromKV", () => testEqual("1", Garter.Object.fromKV("a", 1), {"a": 1}))
