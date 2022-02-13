include Belt.Array

let isEmpty = xs => length(xs) === 0

let firstUnsafe = getUnsafe(_, 0)
let firstExn = getExn(_, 0)
let first = get(_, 0)

let lastUnsafe = ar => getUnsafe(ar, length(ar) - 1)
let lastExn = ar => getExn(ar, length(ar) - 1)
let last = ar => get(ar, length(ar) - 1)

let take = (ar, n) => {
  let len = if n < 0 {
    0
  } else if n > length(ar) {
    length(ar)
  } else {
    n
  }
  Js.Array2.slice(ar, ~start=0, ~end_=len)
}

let takeWhileU = (ar, pred) => {
  let i = ref(0)
  while i.contents < length(ar) && pred(. getUnsafe(ar, i.contents)) {
    i := i.contents + 1
  }
  take(ar, i.contents)
}

let takeWhile = (ar, pred) => takeWhileU(ar, (. x) => pred(x))

let drop = (ar, n) => {
  let offset = if n < 0 {
    0
  } else if n > length(ar) {
    length(ar)
  } else {
    n
  }
  Js.Array2.sliceFrom(ar, offset)
}

let dropWhileU = (ar, pred) => {
  let i = ref(0)
  while i.contents < length(ar) && pred(. getUnsafe(ar, i.contents)) {
    i := i.contents + 1
  }
  drop(ar, i.contents)
}

let dropWhile = (ar, pred) => dropWhileU(ar, (. x) => pred(x))

let updateUnsafeU = (ar, i, f) => {
  let v = getUnsafe(ar, i)
  setUnsafe(ar, i, f(. v))
}

let updateUnsafe = (ar, i, f) => updateUnsafeU(ar, i, (. x) => f(x))

let updateExnU = (ar, i, f) => {
  let v = getExn(ar, i)
  setUnsafe(ar, i, f(. v))
}

let updateExn = (ar, i, f) => updateExnU(ar, i, (. x) => f(x))

let keepSome = xs => keepMap(xs, x => x)

let groupBy = (xs, keyFn, ~id) => {
  let empty = Belt.Map.make(~id)

  reduceU(xs, empty, (. res, x) =>
    Belt.Map.updateU(res, keyFn(x), (. v) =>
      switch v {
      | Some(l) => Some(l->concat([x]))
      | None => Some([x])
      }
    )
  )
}

let indexBy = (xs, indexFn, ~id) => {
  let empty = Belt.Map.make(~id)

  reduceU(xs, empty, (. res, x) => Belt.Map.set(res, indexFn(x), x))
}

let frequencies = (ar, ~id) => groupBy(ar, Garter_Fn.identity, ~id)->Belt.Map.map(length)

let distinct = (ar, ~id) =>
  ar
  ->reduceU((Belt.Set.make(~id), list{}), (. (seen, res), v) =>
    if seen->Belt.Set.has(v) {
      (seen, res)
    } else {
      (seen->Belt.Set.add(v), res->Belt.List.add(v))
    }
  )
  ->snd
  ->Belt.List.reverse
  ->Belt.List.toArray

let scan = (xs, init, f) => {
  let state = makeUninitializedUnsafe(length(xs))
  let cur = ref(init)
  forEachWithIndex(xs, (idx, x) => {
    cur := f(cur.contents, x)
    setUnsafe(state, idx, cur.contents)
  })
  state
}

let chunk = (xs, step) =>
  rangeBy(0, length(xs) - 1, ~step)->map(offset => {
    xs->Js.Array2.slice(~start=offset, ~end_=offset + step)
  })

let randomOne = xs => xs->get(Js.Math.random_int(0, length(xs)))

let randomSample = (xs, prob) => xs->keep(_ => Js.Math.random() < prob)

let intersperse = (xs, delim) => {
  switch xs->length {
  | 0 => []
  | 1 => xs
  | xlen =>
    let ys = make(xlen * 2 - 1, delim)
    xs->forEachWithIndex((i, x) => {
      ys->setUnsafe(i * 2, x)
    })
    ys
  }
}

module Int = {
  // Belt.Map 대신 Belt.Map.Int를 씁니다.
  let groupBy = (xs, keyFn) => {
    let empty = Belt.Map.Int.empty

    reduceU(xs, empty, (. res, x) =>
      Belt.Map.Int.updateU(res, keyFn(x), (. v) =>
        switch v {
        | Some(l) => Some(l->concat([x]))
        | None => Some([x])
        }
      )
    )
  }

  let indexBy = (xs, indexFn) => {
    let empty = Belt.Map.Int.empty

    reduceU(xs, empty, (. res, x) => Belt.Map.Int.set(res, indexFn(x), x))
  }
}

module String = {
  // Belt.Map 대신 Belt.Map.String을 씁니다.
  let groupBy = (xs, keyFn) => {
    let empty = Belt.Map.String.empty

    reduceU(xs, empty, (. res, x) =>
      Belt.Map.String.updateU(res, keyFn(x), (. v) =>
        switch v {
        | Some(l) => Some(l->concat([x]))
        | None => Some([x])
        }
      )
    )
  }

  let indexBy = (xs, indexFn) => {
    let empty = Belt.Map.String.empty

    reduceU(xs, empty, (. res, x) => Belt.Map.String.set(res, indexFn(x), x))
  }
}

module NonEmpty = {
  @unboxed
  type t<'a> = NonEmpty(array<'a>)

  let fromArray = xs =>
    switch xs {
    | [] => None
    | nxs => Some(NonEmpty(nxs))
    }

  let fromArrayExn = xs =>
    switch xs {
    | [] => raise(Invalid_argument("array is empty"))
    | nxs => NonEmpty(nxs)
    }

  let toArray = (NonEmpty(nxs)) => nxs

  let first = (NonEmpty(nxs)) => nxs->firstUnsafe

  let last = (NonEmpty(nxs)) => nxs->lastUnsafe

  let reduce1U = (NonEmpty(xs), f) => {
    let r = ref(xs->getUnsafe(0))
    for i in 1 to length(xs) - 1 {
      r := f(. r.contents, xs->getUnsafe(i))
    }
    r.contents
  }

  let reduce1 = (xs, f) => reduce1U(xs, (. a, x) => f(a, x))

  let minByU = (xs, cmp) => reduce1U(xs, (. a, b) => cmp(. a, b) > 0 ? b : a)

  let minBy = (xs, cmp) => minByU(xs, (. a, b) => cmp(a, b))

  let maxByU = (xs, cmp) => reduce1U(xs, (. a, b) => cmp(. a, b) < 0 ? b : a)

  let maxBy = (xs, cmp) => maxByU(xs, (. a, b) => cmp(a, b))

  let take = (nxs, n) => nxs->toArray->take(n)

  let takeWhileU = (nxs, n) => nxs->toArray->takeWhileU(n)

  let takeWhile = (nxs, n) => nxs->toArray->takeWhile(n)
}
