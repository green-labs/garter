// Js.String2는 ES2015 스펙만 구현하고 있습니다.
// 폴리필을 쓰면 지원 가능한 메서드들을 먼저 Garter에 바인딩 형태로 제공합니다.

include Js.String2

/**
[padEnd n] pads the string with " " (U+0020) so that the resulting string reaches a given length [n].
The padding is applied from the end of the current string.

(ES8)

```
padEnd "200" 5 = "200  "
```
*/
@send
external padEnd: (t, int) => t = "padEnd"

/**
[padEndWith n s] pads the string with a given string [s] (repeated, if needed) so that the resulting string reaches a given length [n].
The padding is applied from the end of the current string.

(ES8)

```
padEndWith "Breaded Mushrooms" 25 "." = "Breaded Mushrooms........"
```
*/
@send
external padEndWith: (t, int, t) => t = "padEnd"

/**
[padStart n] pads the string with " " (U+0020) so that the resulting string reaches a given length [n].
The padding is applied from the start of the current string.

(ES8)

```
padStart "200" 5 = "  200"
```
*/
@send
external padStart: (t, int) => t = "padStart"

/**
[padStartWith n s] pads the string with a given string [s] (repeated, if needed) so that the resulting string reaches a given length [n].
The padding is applied from the start of the current string.

(ES8)

```
padStartWith "Breaded Mushrooms" 25 "." = "........Breaded Mushrooms"
```
*/
@send
external padStartWith: (t, int, t) => t = "padStart"

/**
[trimEnd str] returns a string that is [str] with whitespace stripped from the end.

(ES10)

```
trimEnd "   abc def   " = "   abc def"
trimEnd "\n\r\t abc def \n\n\t\r " = "\n\r\t abc def"
```
*/
@send
external trimEnd: t => t = "trimEnd"

/**
[trimStart str] returns a string that is [str] with whitespace stripped from the beginning.

(ES10)

```
trimStart "   abc def   " = "abc def   "
trimStart "\n\r\t abc def \n\n\t\r " = "abc def \n\n\t\r "
```
*/
@send
external trimStart: t => t = "trimStart"
