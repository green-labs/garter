open Garter.Array;
open Garter.Fn;

assert(take([|1, 2, 3, 4, 5|], -1) == [||]);
assert(take([|1, 2, 3, 4, 5|], 2) == [|1, 2|]);
assert(take([|1, 2, 3, 4, 5|], 7) == [|1, 2, 3, 4, 5|]);
assert(drop([|1, 2, 3, 4, 5|], -1) == [|1, 2, 3, 4, 5|]);
assert(drop([|1, 2, 3, 4, 5|], 2) == [|3, 4, 5|]);
assert(drop([|1, 2, 3, 4, 5|], 7) == [||]);

assert(takeWhile([|1, 2, 3, 4, 5|], x => x <= 2) == [|1, 2|]);
assert(takeWhile([|1, 2, 3, 4, 5|], constantly(false)) == [||]);
assert(dropWhile([|1, 2, 3, 4, 5|], x => x <= 2) == [|3, 4, 5|]);
assert(dropWhile([|1, 2, 3, 4, 5|], Garter_Fn.constantly(true)) == [||]);

assert(minBy([|1, 2, 3, 4, 5|], compare) == 1);
assert(minByU([|1, 2, 3, 4, 5|], (. a, b) => compare(a, b)) == 1);
assert(maxBy([|1, 2, 3, 4, 5|], compare) == 5);
assert(maxByU([|1, 2, 3, 4, 5|], (. a, b) => compare(a, b)) == 5);
