/**
문자열 k와 임의의 값 v로부터 `[{[k]: v}]`에 해당하는 객체를 생성합니다.  
`[Js.Obj.assign]`와 사용하기에 편리합니다.

```
Js.Obj.assign(Js.Obj.empty(), fromKV("a", 1))
```
*/
let fromKV: (string, 'a) => {..}

type t

let any: {..} => t
let any2: ({..}, {..}) => array<t>
let any3: ({..}, {..}, {..}) => array<t>
let any4: ({..}, {..}, {..}, {..}) => array<t>
let any5: ({..}, {..}, {..}, {..}, {..}) => array<t>
let any6: ({..}, {..}, {..}, {..}, {..}, {..}) => array<t>
let any7: ({..}, {..}, {..}, {..}, {..}, {..}, {..}) => array<t>
let isEmpty: {..} => bool

let toJsonUnsafe: {..} => JSON.t
let toJsonExn: {..} => JSON.t
let toJson: {..} => option<JSON.t>
