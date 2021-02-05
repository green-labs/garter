include Belt.List;

let isEmpty = xs => Belt.List.length(xs) === 0;

let takeExn = (list, cnt) => {
  switch (Belt.List.take(list, cnt)) {
  | Some(l) => l
  | None => raise(Not_found)
  };
};

let dropExn = (list, cnt) => {
  switch (Belt.List.drop(list, cnt)) {
  | Some(l) => l
  | None => raise(Not_found)
  };
};

let splitAtExn = (list, n) => (takeExn(list, n), dropExn(list, n));

let reduce1U = (l, f) => {
  switch (l) {
  | [] => raise(Not_found)
  | [x, ...xs] => reduceU(xs, x, f)
  };
};

let reduce1 = (l, f) => reduce1U(l, (. a, x) => f(. a, x));
