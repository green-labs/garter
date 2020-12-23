// Applicative of Belt.Option
let apply = (fa, b) => {
  switch (fa, b) {
  | (Some(f), Some(v)) => Some(f(v))
  | _ => None
  };
};

let (<*>) = apply;
