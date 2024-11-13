// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Belt_List from "rescript/lib/es6/Belt_List.js";

function isEmpty(xs) {
  return Belt_List.length(xs) === 0;
}

function takeExn(l, cnt) {
  let l$1 = Belt_List.take(l, cnt);
  if (l$1 !== undefined) {
    return l$1;
  }
  throw {
    RE_EXN_ID: "Not_found",
    Error: new Error()
  };
}

function dropExn(l, cnt) {
  let l$1 = Belt_List.drop(l, cnt);
  if (l$1 !== undefined) {
    return l$1;
  }
  throw {
    RE_EXN_ID: "Not_found",
    Error: new Error()
  };
}

function splitAtExn(l, n) {
  return [
    takeExn(l, n),
    dropExn(l, n)
  ];
}

function reduce1(l, f) {
  if (l) {
    return Belt_List.reduce(l.tl, l.hd, f);
  }
  throw {
    RE_EXN_ID: "Not_found",
    Error: new Error()
  };
}

let length = Belt_List.length;

let size = Belt_List.size;

let head = Belt_List.head;

let headExn = Belt_List.headExn;

let tail = Belt_List.tail;

let tailExn = Belt_List.tailExn;

let add = Belt_List.add;

let get = Belt_List.get;

let getExn = Belt_List.getExn;

let make = Belt_List.make;

let makeByU = Belt_List.makeByU;

let makeBy = Belt_List.makeBy;

let shuffle = Belt_List.shuffle;

let drop = Belt_List.drop;

let take = Belt_List.take;

let splitAt = Belt_List.splitAt;

let concat = Belt_List.concat;

let concatMany = Belt_List.concatMany;

let reverseConcat = Belt_List.reverseConcat;

let flatten = Belt_List.flatten;

let mapU = Belt_List.mapU;

let map = Belt_List.map;

let zip = Belt_List.zip;

let zipByU = Belt_List.zipByU;

let zipBy = Belt_List.zipBy;

let mapWithIndexU = Belt_List.mapWithIndexU;

let mapWithIndex = Belt_List.mapWithIndex;

let fromArray = Belt_List.fromArray;

let toArray = Belt_List.toArray;

let reverse = Belt_List.reverse;

let mapReverseU = Belt_List.mapReverseU;

let mapReverse = Belt_List.mapReverse;

let forEachU = Belt_List.forEachU;

let forEach = Belt_List.forEach;

let forEachWithIndexU = Belt_List.forEachWithIndexU;

let forEachWithIndex = Belt_List.forEachWithIndex;

let reduceU = Belt_List.reduceU;

let reduce = Belt_List.reduce;

let reduceWithIndexU = Belt_List.reduceWithIndexU;

let reduceWithIndex = Belt_List.reduceWithIndex;

let reduceReverseU = Belt_List.reduceReverseU;

let reduceReverse = Belt_List.reduceReverse;

let mapReverse2U = Belt_List.mapReverse2U;

let mapReverse2 = Belt_List.mapReverse2;

let forEach2U = Belt_List.forEach2U;

let forEach2 = Belt_List.forEach2;

let reduce2U = Belt_List.reduce2U;

let reduce2 = Belt_List.reduce2;

let reduceReverse2U = Belt_List.reduceReverse2U;

let reduceReverse2 = Belt_List.reduceReverse2;

let everyU = Belt_List.everyU;

let every = Belt_List.every;

let someU = Belt_List.someU;

let some = Belt_List.some;

let every2U = Belt_List.every2U;

let every2 = Belt_List.every2;

let some2U = Belt_List.some2U;

let some2 = Belt_List.some2;

let cmpByLength = Belt_List.cmpByLength;

let cmpU = Belt_List.cmpU;

let cmp = Belt_List.cmp;

let eqU = Belt_List.eqU;

let eq = Belt_List.eq;

let hasU = Belt_List.hasU;

let has = Belt_List.has;

let getByU = Belt_List.getByU;

let getBy = Belt_List.getBy;

let keepU = Belt_List.keepU;

let keep = Belt_List.keep;

let filter = Belt_List.filter;

let keepWithIndexU = Belt_List.keepWithIndexU;

let keepWithIndex = Belt_List.keepWithIndex;

let filterWithIndex = Belt_List.filterWithIndex;

let keepMapU = Belt_List.keepMapU;

let keepMap = Belt_List.keepMap;

let partitionU = Belt_List.partitionU;

let partition = Belt_List.partition;

let unzip = Belt_List.unzip;

let getAssocU = Belt_List.getAssocU;

let getAssoc = Belt_List.getAssoc;

let hasAssocU = Belt_List.hasAssocU;

let hasAssoc = Belt_List.hasAssoc;

let removeAssocU = Belt_List.removeAssocU;

let removeAssoc = Belt_List.removeAssoc;

let setAssocU = Belt_List.setAssocU;

let setAssoc = Belt_List.setAssoc;

let sortU = Belt_List.sortU;

let sort = Belt_List.sort;

export {
  length,
  size,
  head,
  headExn,
  tail,
  tailExn,
  add,
  get,
  getExn,
  make,
  makeByU,
  makeBy,
  shuffle,
  drop,
  take,
  splitAt,
  concat,
  concatMany,
  reverseConcat,
  flatten,
  mapU,
  map,
  zip,
  zipByU,
  zipBy,
  mapWithIndexU,
  mapWithIndex,
  fromArray,
  toArray,
  reverse,
  mapReverseU,
  mapReverse,
  forEachU,
  forEach,
  forEachWithIndexU,
  forEachWithIndex,
  reduceU,
  reduce,
  reduceWithIndexU,
  reduceWithIndex,
  reduceReverseU,
  reduceReverse,
  mapReverse2U,
  mapReverse2,
  forEach2U,
  forEach2,
  reduce2U,
  reduce2,
  reduceReverse2U,
  reduceReverse2,
  everyU,
  every,
  someU,
  some,
  every2U,
  every2,
  some2U,
  some2,
  cmpByLength,
  cmpU,
  cmp,
  eqU,
  eq,
  hasU,
  has,
  getByU,
  getBy,
  keepU,
  keep,
  filter,
  keepWithIndexU,
  keepWithIndex,
  filterWithIndex,
  keepMapU,
  keepMap,
  partitionU,
  partition,
  unzip,
  getAssocU,
  getAssoc,
  hasAssocU,
  hasAssoc,
  removeAssocU,
  removeAssoc,
  setAssocU,
  setAssoc,
  sortU,
  sort,
  isEmpty,
  takeExn,
  dropExn,
  splitAtExn,
  reduce1,
}
/* No side effect */
