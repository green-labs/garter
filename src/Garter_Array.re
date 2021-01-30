include Belt.Array;

let isEmpty = xs => Belt.Array.length(xs) === 0;

let lastUnsafe = ar => getUnsafe(ar, length(ar) - 1);

let last = ar => isEmpty(ar) ? None : Some(lastUnsafe(ar));

/**
 * `i`번째 인덱스의 값에 `f`를 수행한 결과를 in-place로 업데이트합니다.
 * `f`는 old value를 받아 new value를 반환하는 함수입니다.
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

/**
 * ~keyFn으로 그루핑된 Belt.Map을 반환합니다.
 * ~id에는 Belt.Id.Comparable 모듈이 전달되어야 합니다.
 * 일반적인 타입에 대한 Comparable 모듈은 Garter.Id를 참고하세요.
 *
 * 예)
 * ```
 * module IntCmp =
 *   Belt.Id.MakeComparable({
 *     type t = int;
 *     let cmp = (a, b) => Pervasives.compare(a, b);
 *   });
 *
 * groupBy(
 *   [|1, 2, 3, 4, 5, 6, 7, 8, 9, 10|],
 *   ~keyFn=x => x mod 3,
 *   ~id=Garter.Id.IntComparable,
 * )
 * ```
 */
let groupBy = (xs, ~keyFn, ~id) => {
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
 * 배열에 들어있는 값들의 빈도를 구하여 Map으로 반환합니다.
 */
let frequencies = (ar, ~id) => {
  groupBy(ar, ~keyFn=x => x, ~id)->Belt.Map.map(Belt.Array.length);
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
