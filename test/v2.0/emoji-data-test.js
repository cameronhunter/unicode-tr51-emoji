import test from "ava";
import codepoints from "../../v2.0/code-points";
import symbols from "../../v2.0/symbols";

test("contains expected code points", t => {
  // U+1F198 SQUARED SOS
  t.truthy(codepoints.indexOf(0x1F198) >= 0);
  t.truthy(symbols.indexOf("\uD83C\uDD98") >= 0);

  // U+1F6B4 BICYCLIST
  t.truthy(codepoints.indexOf(0x1F6B4) >= 0);
  t.truthy(symbols.indexOf("\uD83D\uDEB4") >= 0);

  // U+1F596 RAISED HAND WITH PART BETWEEN MIDDLE AND RING FINGERS
  t.truthy(codepoints.indexOf(0x1F596) >= 0);
  t.truthy(symbols.indexOf("\uD83D\uDD96") >= 0);

  // U+1F3FF EMOJI MODIFIER FITZPATRICK TYPE-6
  t.truthy(codepoints.indexOf(0x1F3FF) >= 0);
  t.truthy(symbols.indexOf("\uD83C\uDFFF") >= 0);
});
