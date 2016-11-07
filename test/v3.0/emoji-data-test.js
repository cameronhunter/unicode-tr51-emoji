import test from "ava";
import codepoints from "../../v3.0/code-points";
import symbols from "../../v3.0/symbols";

test("contains expected code points", t => {
  // U+1F933 SELFIE
  t.truthy(codepoints.indexOf(0x1F933) >= 0);
  t.truthy(symbols.indexOf("\uD83E\uDD33") >= 0);
});
