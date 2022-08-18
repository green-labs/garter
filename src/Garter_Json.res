@val @scope("JSON") external stringifyExn: 'a => option<string> = "stringify"

let stringify = x =>
  try {
    x->stringifyExn
  } catch {
  | _ => None
  }

let parse = s =>
  try {
    s->Js.Json.parseExn->Some
  } catch {
  | _ => None
  }
