/**
 * 문자열 k와 임의의 값 v로부터 `{[k]: v}`에 해당하는 객체를 생성합니다.
 * Js.Obj.assign와 사용하기에 편리합니다.
 * 
 * 예) `Js.Obj.assign(Js.Obj.empty(), fromKV("a", 1))`
 */
let fromKV: (string, 'a) => Js.t({..});

type t;

let any: Js.t({..}) => t;
let any2: (Js.t({..}), Js.t({..})) => array(t);
let any3: (Js.t({..}), Js.t({..}), Js.t({..})) => array(t);
let any4: (Js.t({..}), Js.t({..}), Js.t({..}), Js.t({..})) => array(t);
let any5:
  (Js.t({..}), Js.t({..}), Js.t({..}), Js.t({..}), Js.t({..})) =>
  array(t);
let any6:
  (
    Js.t({..}),
    Js.t({..}),
    Js.t({..}),
    Js.t({..}),
    Js.t({..}),
    Js.t({..})
  ) =>
  array(t);
let any7:
  (
    Js.t({..}),
    Js.t({..}),
    Js.t({..}),
    Js.t({..}),
    Js.t({..}),
    Js.t({..}),
    Js.t({..})
  ) =>
  array(t);
let isEmpty: Js.t({..}) => bool;
