module StringComparable =
  Belt.Id.MakeComparableU({
    type t = string;
    let cmp = (. a, b) => Js.String2.localeCompare(a, b)->int_of_float;
  });

module IntComparable =
  Belt.Id.MakeComparableU({
    type t = int;
    let cmp = (. a, b) => a - b;
  });

module FloatComparable =
  Belt.Id.MakeComparableU({
    type t = float;
    let cmp = (. a, b) => Pervasives.compare(a, b);
  });
