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
