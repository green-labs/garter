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
  while i.contents < length(ar) && pred(getUnsafe(ar, i.contents)) {
    i := i.contents + 1
  }
  take(ar, i.contents)
}

let takeWhile = (ar, pred) => takeWhileU(ar, x => pred(x))

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
  while i.contents < length(ar) && pred(getUnsafe(ar, i.contents)) {
    i := i.contents + 1
  }
  drop(ar, i.contents)
}

let dropWhile = (ar, pred) => dropWhileU(ar, x => pred(x))

let updateUnsafeU = (ar, i, f) => {
  let v = getUnsafe(ar, i)
  setUnsafe(ar, i, f(v))
}

let updateUnsafe = (ar, i, f) => updateUnsafeU(ar, i, x => f(x))

let updateExnU = (ar, i, f) => {
  let v = getExn(ar, i)
  setUnsafe(ar, i, f(v))
}

let updateExn = (ar, i, f) => updateExnU(ar, i, x => f(x))

let keepSome = xs => keepMap(xs, x => x)

let groupBy = (xs, keyFn, ~id) => {
  let empty = Belt.Map.make(~id)

  reduceU(xs, empty, (res, x) =>
    Belt.Map.updateU(res, keyFn(x), v =>
      switch v {
      | Some(l) => Some(l->concat([x]))
      | None => Some([x])
      }
    )
  )
}

let indexBy = (xs, indexFn, ~id) => {
  let empty = Belt.Map.make(~id)

  reduceU(xs, empty, (res, x) => Belt.Map.set(res, indexFn(x), x))
}

let frequencies = (ar, ~id) => groupBy(ar, Garter_Fn.identity, ~id)->Belt.Map.map(length)

let distinctBy = (type a, ar: array<a>, f) => {
  module Comparable = Belt.Id.MakeComparableU({
    type t = a
    let cmp = (a: t, b: t) => Pervasives.compare(f(a), f(b))
  })

  ar
  ->reduceU((Belt.Set.make(~id=module(Comparable)), list{}), ((seen, res), v) =>
    if seen->Belt.Set.has(v) {
      (seen, res)
    } else {
      (seen->Belt.Set.add(v), res->Belt.List.add(v))
    }
  )
  ->snd
  ->Belt.List.reverse
  ->Belt.List.toArray
}

let distinct = ar => {
  ar->distinctBy(x => x)
}

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

    reduceU(xs, empty, (res, x) =>
      Belt.Map.Int.updateU(res, keyFn(x), v =>
        switch v {
        | Some(l) => Some(l->concat([x]))
        | None => Some([x])
        }
      )
    )
  }

  let indexBy = (xs, indexFn) => {
    let empty = Belt.Map.Int.empty

    reduceU(xs, empty, (res, x) => Belt.Map.Int.set(res, indexFn(x), x))
  }
}

module String = {
  let joinWith = (xs, s) => {
    Belt.Array.joinWithU(xs, s, x => x)
  }

  // Belt.Map 대신 Belt.Map.String을 씁니다.
  let groupBy = (xs, keyFn) => {
    let empty = Belt.Map.String.empty

    reduceU(xs, empty, (res, x) =>
      Belt.Map.String.updateU(res, keyFn(x), v =>
        switch v {
        | Some(l) => Some(l->concat([x]))
        | None => Some([x])
        }
      )
    )
  }

  let indexBy = (xs, indexFn) => {
    let empty = Belt.Map.String.empty

    reduceU(xs, empty, (res, x) => Belt.Map.String.set(res, indexFn(x), x))
  }
}

module NonEmpty = {
  type t<'a> = Belt.Array.t<'a>

  let fromArray = xs =>
    switch xs {
    | [] => None
    | nxs => Some(nxs)
    }

  let fromArrayExn = xs =>
    switch xs {
    | [] => raise(Invalid_argument("array is empty"))
    | nxs => nxs
    }

  let toArray = nxs => nxs

  let first = nxs => nxs->firstUnsafe

  let last = nxs => nxs->lastUnsafe

  let reduce1 = (xs, f) => {
    let r = ref(xs->getUnsafe(0))
    for i in 1 to length(xs) - 1 {
      r := f(r.contents, xs->getUnsafe(i))
    }
    r.contents
  }

  let minBy = (xs, cmp) => reduce1(xs, (a, b) => cmp(a, b) > 0 ? b : a)

  let maxBy = (xs, cmp) => reduce1(xs, (a, b) => cmp(a, b) < 0 ? b : a)

  let take = (nxs, n) => nxs->take(n)

  let takeWhile = (nxs, n) => nxs->takeWhileU(n)

  let drop = (nxs, n) => nxs->drop(n)

  let dropWhile = (nxs, pred) => nxs->dropWhileU(pred)

  let updateUnsafe = (nxs, i, f) => nxs->updateUnsafeU(i, f)

  let updateExn = (nxs, i, f) => nxs->updateExnU(i, f)

  let keepSome = nxs => nxs->keepSome

  let groupBy = (nxs, keyFn, ~id) => nxs->groupBy(keyFn, ~id)

  let indexBy = (nxs, indexFn, ~id) => nxs->indexBy(indexFn, ~id)

  let frequencies = (nxs, ~id) => nxs->frequencies(~id)

  let distinct = nxs => nxs->distinct->fromArrayExn

  let distinctBy = (nxs, f) => nxs->distinctBy(f)->fromArrayExn

  let scan = (nxs, init, f) => nxs->scan(init, f)->fromArrayExn

  let chunk = (nxs, step) => nxs->chunk(step)->fromArrayExn

  let randomOne = nxs => nxs->getUnsafe(Js.Math.random_int(0, length(nxs)))

  let randomSample = (nxs, prob) => nxs->randomSample(prob)

  let intersperse = (nxs, delim) => nxs->intersperse(delim)->fromArrayExn

  module Int = {
    let groupBy = (nxs, keyFn) => nxs->Int.groupBy(keyFn)
    let indexBy = (nxs, indexFn) => nxs->Int.indexBy(indexFn)
  }

  module String = {
    let groupBy = (nxs, keyFn) => nxs->String.groupBy(keyFn)
    let indexBy = (nxs, indexFn) => nxs->String.indexBy(indexFn)
    let joinWith = String.joinWith
  }

  let length = xs => Belt.Array.length(xs)

  let size = xs => Belt.Array.size(xs)

  let get = (xs, i) => Belt.Array.get(xs, i)
  let getExn = (xs, i) => Belt.Array.getExn(xs, i)
  let getUnsafe = (xs, i) => Belt.Array.getUnsafe(xs, i)
  let getUndefined = (xs, i) => Belt.Array.getUndefined(xs, i)

  let set = (xs, i, v) => Belt.Array.set(xs, i, v)
  let setExn = (xs, i, v) => Belt.Array.setExn(xs, i, v)
  let setUnsafe = (xs, i, v) => Belt.Array.setUnsafe(xs, i, v)

  let shuffleInPlace = xs => Belt.Array.shuffleInPlace(xs)
  let shuffle = xs => Belt.Array.shuffle(xs)

  let reverseInPlace = xs => Belt.Array.reverseInPlace(xs)
  let reverse = xs => Belt.Array.reverse(xs)

  let zip = (xs, ys) => Belt.Array.zip(xs, ys)
  let zipBy = (xs, ys, f) => Belt.Array.zipByU(xs, ys, f)

  let unzip = xs => Belt.Array.unzip(xs)

  let concat = (xs, ys) => Belt.Array.concat(xs, ys)
  let concatMany = xs => Belt.Array.concatMany(xs)

  let slice = (xs, ~offset, ~len) => Belt.Array.slice(xs, ~offset, ~len)
  let sliceToEnd = (xs, offset) => Belt.Array.sliceToEnd(xs, offset)
  let copy = xs => Belt.Array.copy(xs)

  let fill = (xs, ~offset, ~len, v) => Belt.Array.fill(xs, ~offset, ~len, v)

  let blit = (~src, ~srcOffset, ~dst, ~dstOffset, ~len) =>
    Belt.Array.blit(~src, ~srcOffset, ~dst, ~dstOffset, ~len)
  let blitUnsafe = (~src, ~srcOffset, ~dst, ~dstOffset, ~len) =>
    Belt.Array.blitUnsafe(~src, ~srcOffset, ~dst, ~dstOffset, ~len)

  let forEach = (xs, f) => Belt.Array.forEachU(xs, f)

  let map = (xs, f) => Belt.Array.mapU(xs, f)

  let getBy = (xs, f) => Belt.Array.getByU(xs, f)

  let getIndexBy = (xs, f) => Belt.Array.getIndexByU(xs, f)

  let keep = (xs, f) => Belt.Array.keepU(xs, f)

  let keepWithIndex = (xs, f) => Belt.Array.keepWithIndexU(xs, f)

  let keepMap = (xs, f) => Belt.Array.keepMapU(xs, f)

  let forEachWithIndex = (xs, f) => Belt.Array.forEachWithIndexU(xs, f)

  let mapWithIndex = (xs, f) => Belt.Array.mapWithIndexU(xs, f)

  let partition = (xs, f) => Belt.Array.partitionU(xs, f)

  let reduce = (xs, init, f) => Belt.Array.reduceU(xs, init, f)

  let reduceReverse = (xs, init, f) => Belt.Array.reduceReverseU(xs, init, f)

  let reduceReverse2 = (xs, ys, init, f) => Belt.Array.reduceReverse2U(xs, ys, init, f)

  let reduceWithIndex = (xs, init, f) => Belt.Array.reduceWithIndexU(xs, init, f)

  let joinWith = (xs, v, f) => Belt.Array.joinWithU(xs, v, f)

  let some = (xs, f) => Belt.Array.someU(xs, f)

  let every = (xs, f) => Belt.Array.everyU(xs, f)

  let some2 = (xs, ys, f) => Belt.Array.some2U(xs, ys, f)

  let every2 = (xs, ys, f) => Belt.Array.every2U(xs, ys, f)

  let cmp = (xs, ys, f) => Belt.Array.cmpU(xs, ys, f)

  let eq = (xs, ys, f) => Belt.Array.eqU(xs, ys, f)

  let truncateToLengthUnsafe = (xs, n) => Belt.Array.truncateToLengthUnsafe(xs, n)
}
