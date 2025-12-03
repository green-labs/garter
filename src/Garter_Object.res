let fromKV = %raw(`(k, v) => ({ [k]: v })`)

@unboxed
type rec t = Any({..}): t

let any = a => Any(a)
let any2 = (a, b) => [Any(a), Any(b)]
let any3 = (a, b, c) => [Any(a), Any(b), Any(c)]
let any4 = (a, b, c, d) => [Any(a), Any(b), Any(c), Any(d)]
let any5 = (a, b, c, d, e) => [Any(a), Any(b), Any(c), Any(d), Any(e)]
let any6 = (a, b, c, d, e, f) => [Any(a), Any(b), Any(c), Any(d), Any(e), Any(f)]
let any7 = (a, b, c, d, e, f, g) => [Any(a), Any(b), Any(c), Any(d), Any(e), Any(f), Any(g)]

let isEmpty = o => o->Object.keysToArray->Garter_Array.isEmpty

external toJsonUnsafe: {..} => JSON.t = "%identity"

let toJsonExn = o => o->Garter_Json.stringifyExn->Obj.magic->JSON.parseOrThrow

let toJson = o =>
  try {
    o->toJsonExn->Some
  } catch {
  | _ => None
  }
