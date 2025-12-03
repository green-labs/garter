@val @scope("JSON") external stringifyExn: 'a => option<string> = "stringify"

let stringify = x =>
  try {
    x->stringifyExn
  } catch {
  | _ => None
  }

let parse = s =>
  try {
    s->JSON.parseOrThrow->Some
  } catch {
  | _ => None
  }
