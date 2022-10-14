// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Curry from "@rescript/std/lib/es6/curry.js";
import * as Belt_Option from "@rescript/std/lib/es6/belt_Option.js";
import * as Caml_option from "@rescript/std/lib/es6/caml_option.js";

function apply(fa, b) {
  if (fa !== undefined && b !== undefined) {
    return Caml_option.some(Curry._1(fa, Caml_option.valFromOption(b)));
  }
  
}

var keepU = Belt_Option.keepU;

var keep = Belt_Option.keep;

var forEachU = Belt_Option.forEachU;

var forEach = Belt_Option.forEach;

var getExn = Belt_Option.getExn;

var mapWithDefaultU = Belt_Option.mapWithDefaultU;

var mapWithDefault = Belt_Option.mapWithDefault;

var mapU = Belt_Option.mapU;

var map = Belt_Option.map;

var flatMapU = Belt_Option.flatMapU;

var flatMap = Belt_Option.flatMap;

var getWithDefault = Belt_Option.getWithDefault;

var orElse = Belt_Option.orElse;

var isSome = Belt_Option.isSome;

var isNone = Belt_Option.isNone;

var eqU = Belt_Option.eqU;

var eq = Belt_Option.eq;

var cmpU = Belt_Option.cmpU;

var cmp = Belt_Option.cmp;

var $less$star$great = apply;

export {
  keepU ,
  keep ,
  forEachU ,
  forEach ,
  getExn ,
  mapWithDefaultU ,
  mapWithDefault ,
  mapU ,
  map ,
  flatMapU ,
  flatMap ,
  getWithDefault ,
  orElse ,
  isSome ,
  isNone ,
  eqU ,
  eq ,
  cmpU ,
  cmp ,
  apply ,
  $less$star$great ,
}
/* No side effect */
