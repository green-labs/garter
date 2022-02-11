// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Caml from "@rescript/std/lib/es6/caml.js";
import * as Zora from "@dusty-phillips/rescript-zora/src/Zora.mjs";
import * as Zora$1 from "zora";
import * as Garter_Fn from "../../../src/Garter_Fn.mjs";
import * as Garter_Array from "../../../src/Garter_Array.mjs";

function testEqual(t, name, lhs, rhs) {
  t.test(name, (function (t) {
          t.equal(lhs, rhs, name);
          return Zora.done(undefined);
        }));
  
}

Zora$1.test("take", (function (t) {
        testEqual(t, "1", Garter_Array.take([
                  1,
                  2,
                  3,
                  4,
                  5
                ], -1), []);
        testEqual(t, "2", Garter_Array.take([
                  1,
                  2,
                  3,
                  4,
                  5
                ], 2), [
              1,
              2
            ]);
        return testEqual(t, "3", Garter_Array.take([
                        1,
                        2,
                        3,
                        4,
                        5
                      ], 7), [
                    1,
                    2,
                    3,
                    4,
                    5
                  ]);
      }));

Zora$1.test("drop", (function (t) {
        testEqual(t, "1", Garter_Array.drop([
                  1,
                  2,
                  3,
                  4,
                  5
                ], -1), [
              1,
              2,
              3,
              4,
              5
            ]);
        testEqual(t, "2", Garter_Array.drop([
                  1,
                  2,
                  3,
                  4,
                  5
                ], 2), [
              3,
              4,
              5
            ]);
        return testEqual(t, "3", Garter_Array.drop([
                        1,
                        2,
                        3,
                        4,
                        5
                      ], 7), []);
      }));

Zora$1.test("takeWhile", (function (t) {
        testEqual(t, "1", Garter_Array.takeWhile([
                  1,
                  2,
                  3,
                  4,
                  5
                ], (function (x) {
                    return x <= 2;
                  })), [
              1,
              2
            ]);
        return testEqual(t, "2", Garter_Array.takeWhile([
                        1,
                        2,
                        3,
                        4,
                        5
                      ], (function (param) {
                          return Garter_Fn.constantly(false, param);
                        })), []);
      }));

Zora$1.test("dropWhile", (function (t) {
        testEqual(t, "1", Garter_Array.dropWhile([
                  1,
                  2,
                  3,
                  4,
                  5
                ], (function (x) {
                    return x <= 2;
                  })), [
              3,
              4,
              5
            ]);
        return testEqual(t, "2", Garter_Array.dropWhile([
                        1,
                        2,
                        3,
                        4,
                        5
                      ], (function (param) {
                          return Garter_Fn.constantly(true, param);
                        })), []);
      }));

Zora$1.test("keepSome", (function (t) {
        return testEqual(t, "1", Garter_Array.keepSome([
                        1,
                        undefined,
                        3
                      ]), [
                    1,
                    3
                  ]);
      }));

Zora$1.test("reduce1", (function (t) {
        return testEqual(t, "", Garter_Array.reduce1(Garter_Array.range(1, 10), (function (prim0, prim1) {
                          return prim0 + prim1 | 0;
                        })), 55);
      }));

Zora$1.test("minBy", (function (t) {
        testEqual(t, "1", Garter_Array.minBy([
                  1,
                  2,
                  3,
                  4,
                  5
                ], Caml.caml_int_compare), 1);
        return testEqual(t, "2", Garter_Array.minByU([
                        1,
                        2,
                        3,
                        4,
                        5
                      ], Caml.caml_int_compare), 1);
      }));

Zora$1.test("maxBy", (function (t) {
        testEqual(t, "1", Garter_Array.maxBy([
                  1,
                  2,
                  3,
                  4,
                  5
                ], Caml.caml_int_compare), 5);
        return testEqual(t, "2", Garter_Array.maxByU([
                        1,
                        2,
                        3,
                        4,
                        5
                      ], Caml.caml_int_compare), 5);
      }));

Zora$1.test("intersperse", (function (t) {
        testEqual(t, "1", Garter_Array.intersperse([], 0), []);
        testEqual(t, "2", Garter_Array.intersperse([1], 0), [1]);
        testEqual(t, "3", Garter_Array.intersperse([
                  1,
                  2
                ], 0), [
              1,
              0,
              2
            ]);
        return testEqual(t, "4", Garter_Array.intersperse([
                        1,
                        2,
                        3
                      ], 0), [
                    1,
                    0,
                    2,
                    0,
                    3
                  ]);
      }));

export {
  testEqual ,
  
}
/*  Not a pure module */