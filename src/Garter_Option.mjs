// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Curry from "@rescript/std/lib/es6/curry.js";
import * as Caml_option from "@rescript/std/lib/es6/caml_option.js";

function apply(fa, b) {
  if (fa !== undefined && b !== undefined) {
    return Caml_option.some(Curry._1(fa, Caml_option.valFromOption(b)));
  }
  
}

var $less$star$great = apply;

export {
  apply ,
  $less$star$great ,
  
}
/* No side effect */
