include module type of Belt.List

let isEmpty: Belt.List.t<'a> => bool
let takeExn: (Belt.List.t<'a>, int) => Belt.List.t<'a>
let dropExn: (Belt.List.t<'a>, int) => Belt.List.t<'a>
let splitAtExn: (Belt.List.t<'a>, int) => (Belt.List.t<'a>, Belt.List.t<'a>)
let reduce1U: (list<'a>, (. 'a, 'a) => 'a) => 'a
let reduce1: (list<'a>, (. 'a, 'a) => 'a) => 'a
