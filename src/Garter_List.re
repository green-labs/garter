include Belt.List;

let isEmpty = xs => Belt.List.length(xs) === 0;

let takeExn = (l, cnt) => {
  switch (Belt.List.take(l, cnt)) {
  | Some(l) => l
  | None => raise(Not_found)
  };
};

let dropExn = (l, cnt) => {
  switch (Belt.List.drop(l, cnt)) {
  | Some(l) => l
  | None => raise(Not_found)
  };
};

let splitAtExn = (l, n) => (takeExn(l, n), dropExn(l, n));

let reduce1U = (l, f) => {
  switch (l) {
  | [] => raise(Not_found)
  | [x, ...xs] => reduceU(xs, x, f)
  };
};

let reduce1 = (l, f) => reduce1U(l, (. a, x) => f(. a, x));
