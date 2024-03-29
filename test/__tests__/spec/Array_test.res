open Zora

open Garter.Array
open Garter.Fn

let testEqual = (t, name, lhs, rhs) =>
  t->test(name, async t => {
    t->equal(lhs, rhs, name)
  })

zoraBlock("take", t => {
  t->testEqual("1", take([1, 2, 3, 4, 5], -1), [])
  t->testEqual("2", take([1, 2, 3, 4, 5], 2), [1, 2])
  t->testEqual("3", take([1, 2, 3, 4, 5], 7), [1, 2, 3, 4, 5])
})

zoraBlock("drop", t => {
  t->testEqual("1", drop([1, 2, 3, 4, 5], -1), [1, 2, 3, 4, 5])
  t->testEqual("2", drop([1, 2, 3, 4, 5], 2), [3, 4, 5])
  t->testEqual("3", drop([1, 2, 3, 4, 5], 7), [])
})

zoraBlock("takeWhile", t => {
  t->testEqual("1", takeWhile([1, 2, 3, 4, 5], x => x <= 2), [1, 2])
  t->testEqual("2", takeWhile([1, 2, 3, 4, 5], constantly(false)), [])
})

zoraBlock("dropWhile", t => {
  t->testEqual("1", dropWhile([1, 2, 3, 4, 5], x => x <= 2), [3, 4, 5])
  t->testEqual("2", dropWhile([1, 2, 3, 4, 5], constantly(true)), [])
})

zoraBlock("keepSome", t => t->testEqual("1", keepSome([Some(1), None, Some(3)]), [1, 3]))

zoraBlock("distinct", t => {
  t->testEqual("순서를 유지하면서 중복을 제거한다.", distinct([2, 1, 2]), [2, 1])
})

type a = {
  id: int,
  name: string,
}

zoraBlock("distinctBy", t => {
  t->testEqual(
    "순서를 유지하면서 키에 따라 중복을 제거한다.",
    distinctBy(
      [
        {
          id: 1,
          name: "foo",
        },
        {
          id: 2,
          name: "bar",
        },
        {
          id: 3,
          name: "foo",
        },
      ],
      v => v.name,
    ),
    [
      {
        id: 1,
        name: "foo",
      },
      {
        id: 2,
        name: "bar",
      },
    ],
  )
})

zoraBlock("intersperse", t => {
  t->testEqual("1", intersperse([], 0), [])
  t->testEqual("2", intersperse([1], 0), [1])
  t->testEqual("3", intersperse([1, 2], 0), [1, 0, 2])
  t->testEqual("4", intersperse([1, 2, 3], 0), [1, 0, 2, 0, 3])
})

module String = {
  zoraBlock("joinWith", t => {
    t->testEqual("", String.joinWith([], ","), "")
    t->testEqual("", String.joinWith(["a"], ","), "a")
    t->testEqual("", String.joinWith(["a", "b", "c"], ","), "a,b,c")
  })
}
