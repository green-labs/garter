include Belt.List

let isEmpty = xs => Belt.List.length(xs) === 0

let takeExn = (l, cnt) => {
  switch Belt.List.take(l, cnt) {
  | Some(l) => l
  | None => throw(Not_found)
  }
}

let dropExn = (l, cnt) => {
  switch Belt.List.drop(l, cnt) {
  | Some(l) => l
  | None => throw(Not_found)
  }
}

let splitAtExn = (l, n) => (takeExn(l, n), dropExn(l, n))

let reduce1 = (l, f) => {
  switch l {
  | list{} => throw(Not_found)
  | list{x, ...xs} => reduce(xs, x, f)
  }
}
