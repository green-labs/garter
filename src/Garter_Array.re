include Belt.Array;

let isEmpty = xs => length(xs) === 0;

let lastUnsafe = ar => getUnsafe(ar, length(ar) - 1);

let last = ar => isEmpty(ar) ? None : Some(lastUnsafe(ar));

/**
 * 0번째 인덱스부터 최대 n개의 원소를 반환합니다.
 * n이 음수라면 빈 배열을 반환합니다.
 */
let take = (ar, n) => {
  let len =
    if (n < 0) {
      0;
    } else if (n > length(ar)) {
      length(ar);
    } else {
      n;
    };
  Js.Array2.slice(ar, ~start=0, ~end_=len);
};

let takeWhileU = (ar, pred) => {
  let i = ref(0);
  while (i^ < length(ar) && pred(. getUnsafe(ar, i^))) {
    i := i^ + 1;
  };
  take(ar, i^);
};

let takeWhile = (ar, pred) => takeWhileU(ar, (. x) => pred(x));

/**
 * 0번째 인덱스부터 n개를 제외한 원소들의 배열을 반환합니다.
 * n이 배열의 크기보다 크면 빈 배열 반환합니다.
 */
let drop = (ar, n) => {
  let offset =
    if (n < 0) {
      0;
    } else if (n > length(ar)) {
      length(ar);
    } else {
      n;
    };
  Js.Array2.sliceFrom(ar, offset);
};

let dropWhileU = (ar, pred) => {
  let i = ref(0);
  while (i^ < length(ar) && pred(. getUnsafe(ar, i^))) {
    i := i^ + 1;
  };
  drop(ar, i^);
};

let dropWhile = (ar, pred) => dropWhileU(ar, (. x) => pred(x));

/**
 * `i`번째 인덱스의 값에 `f`를 수행한 결과를 in-place로 업데이트합니다.
 * `f`는 old value를 받아 new value를 반환하는 함수입니다.
 */
let updateUnsafeU = (ar, i, f) => {
  let v = getUnsafe(ar, i);
  setUnsafe(ar, i, f(. v));
};

let updateUnsafe = (ar, i, f) => {
  updateUnsafeU(ar, i, (. x) => f(x));
};

let updateExnU = (ar, i, f) => {
  let v = getExn(ar, i);
  setUnsafe(ar, i, f(. v));
};

let updateExn = (ar, i, f) => {
  updateExnU(ar, i, (. x) => f(x));
};

/**
 * keyFn으로 그루핑된 Belt.Map을 반환합니다.
 * ~id에는 Belt.Id.Comparable 모듈이 전달되어야 합니다.
 * 일반적인 타입에 대한 Comparable 모듈은 Garter.Id를 참고하세요.
 *
 * 예)
 * ```
 * groupBy(
 *   [|1, 2, 3, 4, 5, 6, 7, 8, 9, 10|],
 *   x => x mod 3,
 *   ~id=Garter.Id.IntComparable,
 * )
 * ```
 */
let groupBy = (xs, keyFn, ~id) => {
  let empty = Belt.Map.make(~id);

  reduceU(xs, empty, (. res, x) => {
    Belt.Map.updateU(res, keyFn(x), (. v) =>
      switch (v) {
      | Some(l) => Some(l->concat([|x|]))
      | None => Some([|x|])
      }
    )
  });
};

/**
 * indexFn의 결과값을 Belt.Map의 key로 할당한 값을 반환합니다.
 * indexFn의 결과값이 중복되면 마지막으로 나온 값이 할당됩니다.
 *
 * 예)
 * ```
 * type t = {a:int, b:int}
 * indexBy(
 *   [|{a:1, b:1}, {a:1, b:2}, {a:2, b:2}, {a:3, b:3}|],
 *   keyFn=x => x.a,
 *   ~id=Garter.Id.IntComparable,
 * )
 * // (1, {a:1, b:2}), (2, {a:2, b:2}), (3, {a:3, b:3})
 * ```
 */
let indexBy = (xs, indexFn, ~id) => {
  let empty = Belt.Map.make(~id);

  reduceU(xs, empty, (. res, x) => Belt.Map.set(res, indexFn(x), x));
};

/**
 * 배열에 들어있는 값들의 빈도를 구하여 Map으로 반환합니다.
 */
let frequencies = (ar, ~id) => {
  groupBy(ar, Garter_Fn.identity, ~id)->Belt.Map.map(length);
};

/** 먼저 등장하는 순서를 유지하면서 중복 원소를 제거합니다. */
let distinct = (ar, ~id) => {
  ar
  ->reduceU((Belt.Set.make(~id), []), (. (seen, res), v) =>
      if (seen->Belt.Set.has(v)) {
        (seen, res);
      } else {
        (seen->Belt.Set.add(v), res->Belt.List.add(v));
      }
    )
  ->snd
  ->Belt.List.reverse
  ->Belt.List.toArray;
};

/**
 * reduce와 비슷하나 중간 결과를 모두 포함한 array를 반환합니다.
 */
let scan = (xs, init, f) => {
  let state = makeUninitializedUnsafe(length(xs));
  let cur = ref(init);
  forEachWithIndex(
    xs,
    (idx, x) => {
      cur := f(cur^, x);
      setUnsafe(state, idx, cur^);
    },
  );
  state;
};

// `xs` must be non-empty
let reduce1U = (xs, f) => {
  let r = ref(xs->Belt.Array.getUnsafe(0));
  for (i in 1 to length(xs) - 1) {
    r := f(. r^, xs->Belt.Array.getUnsafe(i));
  };
  r^;
};

let reduce1 = (xs, f) => reduce1U(xs, (. a, x) => f(. a, x));

let minByU = (xs, cmp) => reduce1U(xs, (. a, b) => cmp(. a, b) > 0 ? b : a);

let minBy = (xs, cmp) => minByU(xs, (. a, b) => cmp(a, b));

let maxByU = (xs, cmp) => reduce1U(xs, (. a, b) => cmp(. a, b) < 0 ? b : a);

let maxBy = (xs, cmp) => maxByU(xs, (. a, b) => cmp(a, b));

module Int = {
  // Belt.Map 대신 Belt.Map.Int를 씁니다.
  let groupBy = (xs, keyFn) => {
    let empty = Belt.Map.Int.empty;

    reduceU(xs, empty, (. res, x) => {
      Belt.Map.Int.updateU(res, keyFn(x), (. v) =>
        switch (v) {
        | Some(l) => Some(l->concat([|x|]))
        | None => Some([|x|])
        }
      )
    });
  };

  let indexBy = (xs, indexFn) => {
    let empty = Belt.Map.Int.empty;

    reduceU(xs, empty, (. res, x) => Belt.Map.Int.set(res, indexFn(x), x));
  };
};

module String = {
  // Belt.Map 대신 Belt.Map.String을 씁니다.
  let groupBy = (xs, keyFn) => {
    let empty = Belt.Map.String.empty;

    reduceU(xs, empty, (. res, x) => {
      Belt.Map.String.updateU(res, keyFn(x), (. v) =>
        switch (v) {
        | Some(l) => Some(l->concat([|x|]))
        | None => Some([|x|])
        }
      )
    });
  };

  let indexBy = (xs, indexFn) => {
    let empty = Belt.Map.String.empty;

    reduceU(xs, empty, (. res, x) => {
      Belt.Map.String.set(res, indexFn(x), x)
    });
  };
};
