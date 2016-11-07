import test from "ava";
import codepoints from "../../v4.0/code-points";
import symbols from "../../v4.0/symbols";

test("contains expected code points", t => {
  // U+2640 FEMALE SIGN
  t.truthy(codepoints.indexOf(9792) >= 0);
  t.truthy(symbols.indexOf("\u2640") >= 0);
});
