[@bs.module "./Garter_Object"]
external fromKV: (string, 'a) => Js.t({..}) = "fromKV";

[@unboxed]
type t =
  | Any(Js.t({..})): t;

let any = a => Any(a);
let any2 = (a, b) => [|Any(a), Any(b)|];
let any3 = (a, b, c) => [|Any(a), Any(b), Any(c)|];
let any4 = (a, b, c, d) => [|Any(a), Any(b), Any(c), Any(d)|];
let anyMany = objs => {
  Belt.Array.map(objs, x => Any(x));
};

let isEmpty = o => o->Js.Obj.keys->Garter_Array.isEmpty;
