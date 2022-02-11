// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Curry from "@rescript/std/lib/es6/curry.js";
import * as Js_math from "@rescript/std/lib/es6/js_math.js";
import * as Belt_Map from "@rescript/std/lib/es6/belt_Map.js";
import * as Belt_Set from "@rescript/std/lib/es6/belt_Set.js";
import * as Belt_List from "@rescript/std/lib/es6/belt_List.js";
import * as Garter_Fn from "./Garter_Fn.mjs";
import * as Belt_Array from "@rescript/std/lib/es6/belt_Array.js";
import * as Belt_MapInt from "@rescript/std/lib/es6/belt_MapInt.js";
import * as Belt_MapString from "@rescript/std/lib/es6/belt_MapString.js";

function isEmpty(xs) {
  return xs.length === 0;
}

function firstUnsafe(__x) {
  return __x[0];
}

function firstExn(__x) {
  return Belt_Array.getExn(__x, 0);
}

function first(__x) {
  return Belt_Array.get(__x, 0);
}

function lastUnsafe(ar) {
  return ar[ar.length - 1 | 0];
}

function lastExn(ar) {
  return Belt_Array.getExn(ar, ar.length - 1 | 0);
}

function last(ar) {
  return Belt_Array.get(ar, ar.length - 1 | 0);
}

function take(ar, n) {
  var len = n < 0 ? 0 : (
      n > ar.length ? ar.length : n
    );
  return ar.slice(0, len);
}

function takeWhileU(ar, pred) {
  var i = 0;
  while(i < ar.length && pred(ar[i])) {
    i = i + 1 | 0;
  };
  return take(ar, i);
}

function takeWhile(ar, pred) {
  return takeWhileU(ar, Curry.__1(pred));
}

function drop(ar, n) {
  var offset = n < 0 ? 0 : (
      n > ar.length ? ar.length : n
    );
  return ar.slice(offset);
}

function dropWhileU(ar, pred) {
  var i = 0;
  while(i < ar.length && pred(ar[i])) {
    i = i + 1 | 0;
  };
  return drop(ar, i);
}

function dropWhile(ar, pred) {
  return dropWhileU(ar, Curry.__1(pred));
}

function updateUnsafeU(ar, i, f) {
  var v = ar[i];
  ar[i] = f(v);
  
}

function updateUnsafe(ar, i, f) {
  return updateUnsafeU(ar, i, Curry.__1(f));
}

function updateExnU(ar, i, f) {
  var v = Belt_Array.getExn(ar, i);
  ar[i] = f(v);
  
}

function updateExn(ar, i, f) {
  return updateExnU(ar, i, Curry.__1(f));
}

function keepSome(xs) {
  return Belt_Array.keepMap(xs, (function (x) {
                return x;
              }));
}

function groupBy(xs, keyFn, id) {
  var empty = Belt_Map.make(id);
  return Belt_Array.reduceU(xs, empty, (function (res, x) {
                return Belt_Map.updateU(res, Curry._1(keyFn, x), (function (v) {
                              if (v !== undefined) {
                                return Belt_Array.concat(v, [x]);
                              } else {
                                return [x];
                              }
                            }));
              }));
}

function indexBy(xs, indexFn, id) {
  var empty = Belt_Map.make(id);
  return Belt_Array.reduceU(xs, empty, (function (res, x) {
                return Belt_Map.set(res, Curry._1(indexFn, x), x);
              }));
}

function frequencies(ar, id) {
  return Belt_Map.map(groupBy(ar, Garter_Fn.identity, id), (function (prim) {
                return prim.length;
              }));
}

function distinct(ar, id) {
  return Belt_List.toArray(Belt_List.reverse(Belt_Array.reduceU(ar, [
                        Belt_Set.make(id),
                        /* [] */0
                      ], (function (param, v) {
                          var res = param[1];
                          var seen = param[0];
                          if (Belt_Set.has(seen, v)) {
                            return [
                                    seen,
                                    res
                                  ];
                          } else {
                            return [
                                    Belt_Set.add(seen, v),
                                    Belt_List.add(res, v)
                                  ];
                          }
                        }))[1]));
}

function scan(xs, init, f) {
  var state = new Array(xs.length);
  var cur = {
    contents: init
  };
  Belt_Array.forEachWithIndex(xs, (function (idx, x) {
          cur.contents = Curry._2(f, cur.contents, x);
          state[idx] = cur.contents;
          
        }));
  return state;
}

function reduce1U(xs, f) {
  var r = xs[0];
  for(var i = 1 ,i_finish = xs.length; i < i_finish; ++i){
    r = f(r, xs[i]);
  }
  return r;
}

function reduce1(xs, f) {
  return reduce1U(xs, Curry.__2(f));
}

function minByU(xs, cmp) {
  return reduce1U(xs, (function (a, b) {
                if (cmp(a, b) > 0) {
                  return b;
                } else {
                  return a;
                }
              }));
}

function minBy(xs, cmp) {
  return minByU(xs, Curry.__2(cmp));
}

function maxByU(xs, cmp) {
  return reduce1U(xs, (function (a, b) {
                if (cmp(a, b) < 0) {
                  return b;
                } else {
                  return a;
                }
              }));
}

function maxBy(xs, cmp) {
  return maxByU(xs, Curry.__2(cmp));
}

function chunk(xs, step) {
  return Belt_Array.map(Belt_Array.rangeBy(0, xs.length - 1 | 0, step), (function (offset) {
                return xs.slice(offset, offset + step | 0);
              }));
}

function randomOne(xs) {
  return Belt_Array.get(xs, Js_math.random_int(0, xs.length));
}

function randomSample(xs, prob) {
  return Belt_Array.keep(xs, (function (param) {
                return Math.random() < prob;
              }));
}

function intersperse(xs, delim) {
  var xlen = xs.length;
  if (xlen === 0) {
    return [];
  }
  if (xlen === 1) {
    return xs;
  }
  var ys = Belt_Array.make((xlen << 1) - 1 | 0, delim);
  Belt_Array.forEachWithIndex(xs, (function (i, x) {
          ys[(i << 1)] = x;
          
        }));
  return ys;
}

function groupBy$1(xs, keyFn) {
  return Belt_Array.reduceU(xs, undefined, (function (res, x) {
                return Belt_MapInt.updateU(res, Curry._1(keyFn, x), (function (v) {
                              if (v !== undefined) {
                                return Belt_Array.concat(v, [x]);
                              } else {
                                return [x];
                              }
                            }));
              }));
}

function indexBy$1(xs, indexFn) {
  return Belt_Array.reduceU(xs, undefined, (function (res, x) {
                return Belt_MapInt.set(res, Curry._1(indexFn, x), x);
              }));
}

var Int = {
  groupBy: groupBy$1,
  indexBy: indexBy$1
};

function groupBy$2(xs, keyFn) {
  return Belt_Array.reduceU(xs, undefined, (function (res, x) {
                return Belt_MapString.updateU(res, Curry._1(keyFn, x), (function (v) {
                              if (v !== undefined) {
                                return Belt_Array.concat(v, [x]);
                              } else {
                                return [x];
                              }
                            }));
              }));
}

function indexBy$2(xs, indexFn) {
  return Belt_Array.reduceU(xs, undefined, (function (res, x) {
                return Belt_MapString.set(res, Curry._1(indexFn, x), x);
              }));
}

var $$String = {
  groupBy: groupBy$2,
  indexBy: indexBy$2
};

function fromArray(xs) {
  if (xs.length === 0) {
    return ;
  } else {
    return /* NonEmptyArray */{
            _0: xs
          };
  }
}

function toArray(nxs) {
  return nxs._0;
}

function first$1(nxs) {
  return nxs._0[0];
}

function last$1(nxs) {
  return lastUnsafe(nxs._0);
}

function take$1(nxs, n) {
  return take(nxs._0, n);
}

function takeWhileU$1(nxs, n) {
  return takeWhileU(nxs._0, n);
}

function takeWhile$1(nxs, n) {
  return takeWhileU(nxs._0, Curry.__1(n));
}

var NonEmpty = {
  fromArray: fromArray,
  toArray: toArray,
  first: first$1,
  last: last$1,
  take: take$1,
  takeWhileU: takeWhileU$1,
  takeWhile: takeWhile$1
};

var get = Belt_Array.get;

var getExn = Belt_Array.getExn;

var set = Belt_Array.set;

var setExn = Belt_Array.setExn;

var shuffleInPlace = Belt_Array.shuffleInPlace;

var shuffle = Belt_Array.shuffle;

var reverseInPlace = Belt_Array.reverseInPlace;

var reverse = Belt_Array.reverse;

var make = Belt_Array.make;

var range = Belt_Array.range;

var rangeBy = Belt_Array.rangeBy;

var makeByU = Belt_Array.makeByU;

var makeBy = Belt_Array.makeBy;

var makeByAndShuffleU = Belt_Array.makeByAndShuffleU;

var makeByAndShuffle = Belt_Array.makeByAndShuffle;

var zip = Belt_Array.zip;

var zipByU = Belt_Array.zipByU;

var zipBy = Belt_Array.zipBy;

var unzip = Belt_Array.unzip;

var concat = Belt_Array.concat;

var concatMany = Belt_Array.concatMany;

var slice = Belt_Array.slice;

var sliceToEnd = Belt_Array.sliceToEnd;

var fill = Belt_Array.fill;

var blit = Belt_Array.blit;

var blitUnsafe = Belt_Array.blitUnsafe;

var forEachU = Belt_Array.forEachU;

var forEach = Belt_Array.forEach;

var mapU = Belt_Array.mapU;

var map = Belt_Array.map;

var getByU = Belt_Array.getByU;

var getBy = Belt_Array.getBy;

var getIndexByU = Belt_Array.getIndexByU;

var getIndexBy = Belt_Array.getIndexBy;

var keepU = Belt_Array.keepU;

var keep = Belt_Array.keep;

var keepWithIndexU = Belt_Array.keepWithIndexU;

var keepWithIndex = Belt_Array.keepWithIndex;

var keepMapU = Belt_Array.keepMapU;

var keepMap = Belt_Array.keepMap;

var forEachWithIndexU = Belt_Array.forEachWithIndexU;

var forEachWithIndex = Belt_Array.forEachWithIndex;

var mapWithIndexU = Belt_Array.mapWithIndexU;

var mapWithIndex = Belt_Array.mapWithIndex;

var partitionU = Belt_Array.partitionU;

var partition = Belt_Array.partition;

var reduceU = Belt_Array.reduceU;

var reduce = Belt_Array.reduce;

var reduceReverseU = Belt_Array.reduceReverseU;

var reduceReverse = Belt_Array.reduceReverse;

var reduceReverse2U = Belt_Array.reduceReverse2U;

var reduceReverse2 = Belt_Array.reduceReverse2;

var reduceWithIndexU = Belt_Array.reduceWithIndexU;

var reduceWithIndex = Belt_Array.reduceWithIndex;

var joinWithU = Belt_Array.joinWithU;

var joinWith = Belt_Array.joinWith;

var someU = Belt_Array.someU;

var some = Belt_Array.some;

var everyU = Belt_Array.everyU;

var every = Belt_Array.every;

var every2U = Belt_Array.every2U;

var every2 = Belt_Array.every2;

var some2U = Belt_Array.some2U;

var some2 = Belt_Array.some2;

var cmpU = Belt_Array.cmpU;

var cmp = Belt_Array.cmp;

var eqU = Belt_Array.eqU;

var eq = Belt_Array.eq;

export {
  get ,
  getExn ,
  set ,
  setExn ,
  shuffleInPlace ,
  shuffle ,
  reverseInPlace ,
  reverse ,
  make ,
  range ,
  rangeBy ,
  makeByU ,
  makeBy ,
  makeByAndShuffleU ,
  makeByAndShuffle ,
  zip ,
  zipByU ,
  zipBy ,
  unzip ,
  concat ,
  concatMany ,
  slice ,
  sliceToEnd ,
  fill ,
  blit ,
  blitUnsafe ,
  forEachU ,
  forEach ,
  mapU ,
  map ,
  getByU ,
  getBy ,
  getIndexByU ,
  getIndexBy ,
  keepU ,
  keep ,
  keepWithIndexU ,
  keepWithIndex ,
  keepMapU ,
  keepMap ,
  forEachWithIndexU ,
  forEachWithIndex ,
  mapWithIndexU ,
  mapWithIndex ,
  partitionU ,
  partition ,
  reduceU ,
  reduce ,
  reduceReverseU ,
  reduceReverse ,
  reduceReverse2U ,
  reduceReverse2 ,
  reduceWithIndexU ,
  reduceWithIndex ,
  joinWithU ,
  joinWith ,
  someU ,
  some ,
  everyU ,
  every ,
  every2U ,
  every2 ,
  some2U ,
  some2 ,
  cmpU ,
  cmp ,
  eqU ,
  eq ,
  isEmpty ,
  firstUnsafe ,
  firstExn ,
  first ,
  lastUnsafe ,
  lastExn ,
  last ,
  take ,
  takeWhileU ,
  takeWhile ,
  drop ,
  dropWhileU ,
  dropWhile ,
  updateUnsafeU ,
  updateUnsafe ,
  updateExnU ,
  updateExn ,
  keepSome ,
  groupBy ,
  indexBy ,
  frequencies ,
  distinct ,
  scan ,
  reduce1U ,
  reduce1 ,
  minByU ,
  minBy ,
  maxByU ,
  maxBy ,
  chunk ,
  randomOne ,
  randomSample ,
  intersperse ,
  Int ,
  $$String ,
  NonEmpty ,
  
}
/* No side effect */
