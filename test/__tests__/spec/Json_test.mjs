// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Zora from "zora";
import * as Js_dict from "@rescript/std/lib/es6/js_dict.js";
import * as Belt_Option from "@rescript/std/lib/es6/belt_Option.js";
import * as Garter_Json from "../../../src/Garter_Json.mjs";

function testEqual(t, name, lhs, rhs) {
  t.test(name, (async function (t) {
          t.equal(lhs, rhs, name);
        }));
}

Zora.test("[Json] stringifyExn", (function (t) {
        t.test("object", (async function (t) {
                t.equal(Garter_Json.stringifyExn({
                          x: 0
                        }), "{\"x\":0}", "");
              }));
        t.test("undefined", (async function (t) {
                t.equal(Garter_Json.stringifyExn(undefined), undefined, "");
              }));
      }));

Zora.test("[Json] stringify", (function (t) {
        t.test("object", (async function (t) {
                t.equal(Garter_Json.stringify({
                          x: 0
                        }), "{\"x\":0}", "");
              }));
        t.test("undefined", (async function (t) {
                t.equal(Garter_Json.stringify(undefined), undefined, "");
              }));
      }));

Zora.test("[Json] parse", (function (t) {
        t.test("object", (async function (t) {
                t.equal(Belt_Option.flatMap(Garter_Json.stringify({
                              x: 0
                            }), Garter_Json.parse), Js_dict.fromArray([[
                            "x",
                            0.0
                          ]]), "");
              }));
        t.test("undefined", (async function (t) {
                t.equal(Garter_Json.parse(undefined), undefined, "");
              }));
      }));

function roundtrip(json) {
  return Belt_Option.flatMap(Garter_Json.stringify(json), Garter_Json.parse);
}

Zora.test("[Json] roundtrip", (function (t) {
        t.test("json", (async function (t) {
                var json = Js_dict.fromArray([[
                        "x",
                        0.0
                      ]]);
                t.equal(roundtrip(json), json, "");
              }));
      }));

export {
  testEqual ,
  roundtrip ,
}
/*  Not a pure module */
