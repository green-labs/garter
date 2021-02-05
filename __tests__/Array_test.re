open Garter.Array;

assert(minBy([|1, 2, 3, 4, 5|], compare) == 1);
assert(minByU([|1, 2, 3, 4, 5|], (. a, b) => compare(a, b)) == 1);
assert(maxBy([|1, 2, 3, 4, 5|], compare) == 5);
assert(maxByU([|1, 2, 3, 4, 5|], (. a, b) => compare(a, b)) == 5);
