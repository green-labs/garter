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

module Int64Comparable =
  Belt.Id.MakeComparableU({
    type t = Int64.t;
    let cmp = (. a, b) => Int64.compare(a, b);
  });

// 정말 필요한 것인지 다시 생각해기
module FloatComparable =
  Belt.Id.MakeComparableU({
    type t = float;
    let cmp = (. a, b) => Pervasives.compare(a, b);
  });
