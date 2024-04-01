// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Belt_Id from "@rescript/std/lib/es6/belt_Id.js";
import * as Js_math from "@rescript/std/lib/es6/js_math.js";
import * as Belt_Map from "@rescript/std/lib/es6/belt_Map.js";
import * as Belt_Set from "@rescript/std/lib/es6/belt_Set.js";
import * as Caml_obj from "@rescript/std/lib/es6/caml_obj.js";
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
  return takeWhileU(ar, (function (x) {
                return pred(x);
              }));
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
  return dropWhileU(ar, (function (x) {
                return pred(x);
              }));
}

function updateUnsafeU(ar, i, f) {
  var v = ar[i];
  ar[i] = f(v);
}

function updateUnsafe(ar, i, f) {
  updateUnsafeU(ar, i, (function (x) {
          return f(x);
        }));
}

function updateExnU(ar, i, f) {
  var v = Belt_Array.getExn(ar, i);
  ar[i] = f(v);
}

function updateExn(ar, i, f) {
  updateExnU(ar, i, (function (x) {
          return f(x);
        }));
}

function keepSome(xs) {
  return Belt_Array.keepMap(xs, (function (x) {
                return x;
              }));
}

function groupBy(xs, keyFn, id) {
  var empty = Belt_Map.make(id);
  return Belt_Array.reduceU(xs, empty, (function (res, x) {
                return Belt_Map.updateU(res, keyFn(x), (function (v) {
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
                return Belt_Map.set(res, indexFn(x), x);
              }));
}

function frequencies(ar, id) {
  return Belt_Map.map(groupBy(ar, Garter_Fn.identity, id), (function (prim) {
                return prim.length;
              }));
}

function distinctBy(ar, f) {
  var cmp = function (a, b) {
    return Caml_obj.compare(f(a), f(b));
  };
  var Comparable = Belt_Id.MakeComparableU({
        cmp: cmp
      });
  return Belt_List.toArray(Belt_List.reverse(Belt_Array.reduceU(ar, [
                        Belt_Set.make(Comparable),
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

function distinct(ar) {
  return distinctBy(ar, (function (x) {
                return x;
              }));
}

function scan(xs, init, f) {
  var state = new Array(xs.length);
  var cur = {
    contents: init
  };
  Belt_Array.forEachWithIndex(xs, (function (idx, x) {
          cur.contents = f(cur.contents, x);
          state[idx] = cur.contents;
        }));
  return state;
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
                return Belt_MapInt.updateU(res, keyFn(x), (function (v) {
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
                return Belt_MapInt.set(res, indexFn(x), x);
              }));
}

var Int = {
  groupBy: groupBy$1,
  indexBy: indexBy$1
};

function joinWith(xs, s) {
  return Belt_Array.joinWithU(xs, s, (function (x) {
                return x;
              }));
}

function groupBy$2(xs, keyFn) {
  return Belt_Array.reduceU(xs, undefined, (function (res, x) {
                return Belt_MapString.updateU(res, keyFn(x), (function (v) {
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
                return Belt_MapString.set(res, indexFn(x), x);
              }));
}

var $$String = {
  joinWith: joinWith,
  groupBy: groupBy$2,
  indexBy: indexBy$2
};

function fromArray(xs) {
  if (xs.length !== 0) {
    return xs;
  }
  
}

function fromArrayExn(xs) {
  if (xs.length !== 0) {
    return xs;
  }
  throw {
        RE_EXN_ID: "Invalid_argument",
        _1: "array is empty",
        Error: new Error()
      };
}

function toArray(nxs) {
  return nxs;
}

function first$1(nxs) {
  return nxs[0];
}

function last$1(nxs) {
  return lastUnsafe(nxs);
}

function reduce1(xs, f) {
  var r = xs[0];
  for(var i = 1 ,i_finish = xs.length; i < i_finish; ++i){
    r = f(r, xs[i]);
  }
  return r;
}

function minBy(xs, cmp) {
  return reduce1(xs, (function (a, b) {
                if (cmp(a, b) > 0) {
                  return b;
                } else {
                  return a;
                }
              }));
}

function maxBy(xs, cmp) {
  return reduce1(xs, (function (a, b) {
                if (cmp(a, b) < 0) {
                  return b;
                } else {
                  return a;
                }
              }));
}

function take$1(nxs, n) {
  return take(nxs, n);
}

function takeWhile$1(nxs, n) {
  return takeWhileU(nxs, n);
}

function drop$1(nxs, n) {
  return drop(nxs, n);
}

function dropWhile$1(nxs, pred) {
  return dropWhileU(nxs, pred);
}

function updateUnsafe$1(nxs, i, f) {
  updateUnsafeU(nxs, i, f);
}

function updateExn$1(nxs, i, f) {
  updateExnU(nxs, i, f);
}

function keepSome$1(nxs) {
  return Belt_Array.keepMap(nxs, (function (x) {
                return x;
              }));
}

function groupBy$3(nxs, keyFn, id) {
  return groupBy(nxs, keyFn, id);
}

function indexBy$3(nxs, indexFn, id) {
  return indexBy(nxs, indexFn, id);
}

function frequencies$1(nxs, id) {
  return frequencies(nxs, id);
}

function distinct$1(nxs) {
  return fromArrayExn(distinctBy(nxs, (function (x) {
                    return x;
                  })));
}

function distinctBy$1(nxs, f) {
  return fromArrayExn(distinctBy(nxs, f));
}

function scan$1(nxs, init, f) {
  return fromArrayExn(scan(nxs, init, f));
}

function chunk$1(nxs, step) {
  return fromArrayExn(chunk(nxs, step));
}

function randomOne$1(nxs) {
  return nxs[Js_math.random_int(0, nxs.length)];
}

function randomSample$1(nxs, prob) {
  return randomSample(nxs, prob);
}

function intersperse$1(nxs, delim) {
  return fromArrayExn(intersperse(nxs, delim));
}

function groupBy$4(nxs, keyFn) {
  return groupBy$1(nxs, keyFn);
}

function indexBy$4(nxs, indexFn) {
  return indexBy$1(nxs, indexFn);
}

var Int$1 = {
  groupBy: groupBy$4,
  indexBy: indexBy$4
};

function groupBy$5(nxs, keyFn) {
  return groupBy$2(nxs, keyFn);
}

function indexBy$5(nxs, indexFn) {
  return indexBy$2(nxs, indexFn);
}

function length(xs) {
  return xs.length;
}

function size(xs) {
  return xs.length;
}

var get = Belt_Array.get;

var getExn = Belt_Array.getExn;

function getUnsafe(xs, i) {
  return xs[i];
}

function getUndefined(xs, i) {
  return xs[i];
}

var set = Belt_Array.set;

var setExn = Belt_Array.setExn;

function setUnsafe(xs, i, v) {
  xs[i] = v;
}

var shuffleInPlace = Belt_Array.shuffleInPlace;

var shuffle = Belt_Array.shuffle;

var reverseInPlace = Belt_Array.reverseInPlace;

var reverse = Belt_Array.reverse;

var zip = Belt_Array.zip;

var zipBy = Belt_Array.zipByU;

var unzip = Belt_Array.unzip;

var concat = Belt_Array.concat;

var concatMany = Belt_Array.concatMany;

var slice = Belt_Array.slice;

var sliceToEnd = Belt_Array.sliceToEnd;

function copy(xs) {
  return xs.slice(0);
}

var fill = Belt_Array.fill;

var blit = Belt_Array.blit;

var blitUnsafe = Belt_Array.blitUnsafe;

var forEach = Belt_Array.forEachU;

var map = Belt_Array.mapU;

var getBy = Belt_Array.getByU;

var getIndexBy = Belt_Array.getIndexByU;

var keep = Belt_Array.keepU;

var keepWithIndex = Belt_Array.keepWithIndexU;

var keepMap = Belt_Array.keepMapU;

var forEachWithIndex = Belt_Array.forEachWithIndexU;

var mapWithIndex = Belt_Array.mapWithIndexU;

var partition = Belt_Array.partitionU;

var reduce = Belt_Array.reduceU;

var reduceReverse = Belt_Array.reduceReverseU;

var reduceReverse2 = Belt_Array.reduceReverse2U;

var reduceWithIndex = Belt_Array.reduceWithIndexU;

var joinWith$1 = Belt_Array.joinWithU;

var some = Belt_Array.someU;

var every = Belt_Array.everyU;

var some2 = Belt_Array.some2U;

var every2 = Belt_Array.every2U;

var cmp = Belt_Array.cmpU;

var eq = Belt_Array.eqU;

function truncateToLengthUnsafe(xs, n) {
  xs.length = n;
}

var get$1 = Belt_Array.get;

var getExn$1 = Belt_Array.getExn;

var set$1 = Belt_Array.set;

var setExn$1 = Belt_Array.setExn;

var shuffleInPlace$1 = Belt_Array.shuffleInPlace;

var shuffle$1 = Belt_Array.shuffle;

var reverseInPlace$1 = Belt_Array.reverseInPlace;

var reverse$1 = Belt_Array.reverse;

var make = Belt_Array.make;

var range = Belt_Array.range;

var rangeBy = Belt_Array.rangeBy;

var makeByU = Belt_Array.makeByU;

var makeBy = Belt_Array.makeBy;

var makeByAndShuffleU = Belt_Array.makeByAndShuffleU;

var makeByAndShuffle = Belt_Array.makeByAndShuffle;

var zip$1 = Belt_Array.zip;

var zipByU = Belt_Array.zipByU;

var zipBy$1 = Belt_Array.zipBy;

var unzip$1 = Belt_Array.unzip;

var concat$1 = Belt_Array.concat;

var concatMany$1 = Belt_Array.concatMany;

var slice$1 = Belt_Array.slice;

var sliceToEnd$1 = Belt_Array.sliceToEnd;

var fill$1 = Belt_Array.fill;

var blit$1 = Belt_Array.blit;

var blitUnsafe$1 = Belt_Array.blitUnsafe;

var forEachU = Belt_Array.forEachU;

var forEach$1 = Belt_Array.forEach;

var mapU = Belt_Array.mapU;

var map$1 = Belt_Array.map;

var flatMapU = Belt_Array.flatMapU;

var flatMap = Belt_Array.flatMap;

var getByU = Belt_Array.getByU;

var getBy$1 = Belt_Array.getBy;

var getIndexByU = Belt_Array.getIndexByU;

var getIndexBy$1 = Belt_Array.getIndexBy;

var keepU = Belt_Array.keepU;

var keep$1 = Belt_Array.keep;

var keepWithIndexU = Belt_Array.keepWithIndexU;

var keepWithIndex$1 = Belt_Array.keepWithIndex;

var keepMapU = Belt_Array.keepMapU;

var keepMap$1 = Belt_Array.keepMap;

var forEachWithIndexU = Belt_Array.forEachWithIndexU;

var forEachWithIndex$1 = Belt_Array.forEachWithIndex;

var mapWithIndexU = Belt_Array.mapWithIndexU;

var mapWithIndex$1 = Belt_Array.mapWithIndex;

var partitionU = Belt_Array.partitionU;

var partition$1 = Belt_Array.partition;

var reduceU = Belt_Array.reduceU;

var reduce$1 = Belt_Array.reduce;

var reduceReverseU = Belt_Array.reduceReverseU;

var reduceReverse$1 = Belt_Array.reduceReverse;

var reduceReverse2U = Belt_Array.reduceReverse2U;

var reduceReverse2$1 = Belt_Array.reduceReverse2;

var reduceWithIndexU = Belt_Array.reduceWithIndexU;

var reduceWithIndex$1 = Belt_Array.reduceWithIndex;

var joinWithU = Belt_Array.joinWithU;

var joinWith$2 = Belt_Array.joinWith;

var someU = Belt_Array.someU;

var some$1 = Belt_Array.some;

var everyU = Belt_Array.everyU;

var every$1 = Belt_Array.every;

var every2U = Belt_Array.every2U;

var every2$1 = Belt_Array.every2;

var some2U = Belt_Array.some2U;

var some2$1 = Belt_Array.some2;

var cmpU = Belt_Array.cmpU;

var cmp$1 = Belt_Array.cmp;

var eqU = Belt_Array.eqU;

var eq$1 = Belt_Array.eq;

var initU = Belt_Array.initU;

var init = Belt_Array.init;

var NonEmpty_String = {
  joinWith: joinWith,
  groupBy: groupBy$5,
  indexBy: indexBy$5
};

var NonEmpty = {
  length: length,
  size: size,
  get: get,
  getExn: getExn,
  getUnsafe: getUnsafe,
  getUndefined: getUndefined,
  set: set,
  setExn: setExn,
  setUnsafe: setUnsafe,
  shuffleInPlace: shuffleInPlace,
  shuffle: shuffle,
  reverseInPlace: reverseInPlace,
  reverse: reverse,
  zip: zip,
  zipBy: zipBy,
  unzip: unzip,
  concat: concat,
  concatMany: concatMany,
  slice: slice,
  sliceToEnd: sliceToEnd,
  copy: copy,
  fill: fill,
  blit: blit,
  blitUnsafe: blitUnsafe,
  forEach: forEach,
  map: map,
  getBy: getBy,
  getIndexBy: getIndexBy,
  keep: keep,
  keepWithIndex: keepWithIndex,
  keepMap: keepMap,
  forEachWithIndex: forEachWithIndex,
  mapWithIndex: mapWithIndex,
  partition: partition,
  reduce: reduce,
  reduceReverse: reduceReverse,
  reduceReverse2: reduceReverse2,
  reduceWithIndex: reduceWithIndex,
  joinWith: joinWith$1,
  some: some,
  every: every,
  some2: some2,
  every2: every2,
  cmp: cmp,
  eq: eq,
  truncateToLengthUnsafe: truncateToLengthUnsafe,
  fromArray: fromArray,
  fromArrayExn: fromArrayExn,
  toArray: toArray,
  first: first$1,
  last: last$1,
  reduce1: reduce1,
  minBy: minBy,
  maxBy: maxBy,
  take: take$1,
  takeWhile: takeWhile$1,
  drop: drop$1,
  dropWhile: dropWhile$1,
  updateUnsafe: updateUnsafe$1,
  updateExn: updateExn$1,
  keepSome: keepSome$1,
  groupBy: groupBy$3,
  indexBy: indexBy$3,
  frequencies: frequencies$1,
  distinct: distinct$1,
  distinctBy: distinctBy$1,
  scan: scan$1,
  chunk: chunk$1,
  randomOne: randomOne$1,
  randomSample: randomSample$1,
  intersperse: intersperse$1,
  Int: Int$1,
  $$String: NonEmpty_String
};

export {
  get$1 as get,
  getExn$1 as getExn,
  set$1 as set,
  setExn$1 as setExn,
  shuffleInPlace$1 as shuffleInPlace,
  shuffle$1 as shuffle,
  reverseInPlace$1 as reverseInPlace,
  reverse$1 as reverse,
  make ,
  range ,
  rangeBy ,
  makeByU ,
  makeBy ,
  makeByAndShuffleU ,
  makeByAndShuffle ,
  zip$1 as zip,
  zipByU ,
  zipBy$1 as zipBy,
  unzip$1 as unzip,
  concat$1 as concat,
  concatMany$1 as concatMany,
  slice$1 as slice,
  sliceToEnd$1 as sliceToEnd,
  fill$1 as fill,
  blit$1 as blit,
  blitUnsafe$1 as blitUnsafe,
  forEachU ,
  forEach$1 as forEach,
  mapU ,
  map$1 as map,
  flatMapU ,
  flatMap ,
  getByU ,
  getBy$1 as getBy,
  getIndexByU ,
  getIndexBy$1 as getIndexBy,
  keepU ,
  keep$1 as keep,
  keepWithIndexU ,
  keepWithIndex$1 as keepWithIndex,
  keepMapU ,
  keepMap$1 as keepMap,
  forEachWithIndexU ,
  forEachWithIndex$1 as forEachWithIndex,
  mapWithIndexU ,
  mapWithIndex$1 as mapWithIndex,
  partitionU ,
  partition$1 as partition,
  reduceU ,
  reduce$1 as reduce,
  reduceReverseU ,
  reduceReverse$1 as reduceReverse,
  reduceReverse2U ,
  reduceReverse2$1 as reduceReverse2,
  reduceWithIndexU ,
  reduceWithIndex$1 as reduceWithIndex,
  joinWithU ,
  joinWith$2 as joinWith,
  someU ,
  some$1 as some,
  everyU ,
  every$1 as every,
  every2U ,
  every2$1 as every2,
  some2U ,
  some2$1 as some2,
  cmpU ,
  cmp$1 as cmp,
  eqU ,
  eq$1 as eq,
  initU ,
  init ,
  isEmpty ,
  firstUnsafe ,
  firstExn ,
  first ,
  lastUnsafe ,
  lastExn ,
  last ,
  take ,
  takeWhile ,
  drop ,
  dropWhile ,
  updateUnsafe ,
  updateExn ,
  keepSome ,
  groupBy ,
  indexBy ,
  frequencies ,
  distinctBy ,
  distinct ,
  scan ,
  chunk ,
  randomOne ,
  randomSample ,
  intersperse ,
  Int ,
  $$String ,
  NonEmpty ,
}
/* No side effect */
