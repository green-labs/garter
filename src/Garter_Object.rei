let fromKV: (string, 'a) => Js.t({..});

type t;

let any: Js.t({..}) => t;
let any2: (Js.t({..}), Js.t({..})) => array(t);
let any3: (Js.t({..}), Js.t({..}), Js.t({..})) => array(t);
let any4: (Js.t({..}), Js.t({..}), Js.t({..}), Js.t({..})) => array(t);
let anyMany: array(Js.t({..})) => array(t);
