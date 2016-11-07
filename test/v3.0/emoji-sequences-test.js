import test from "ava";
import sequences from "../../v3.0/emoji-sequences";

test("contains unicode 9.0 man dancing", t => {
  t.truthy(sequences.find((item) => item.symbol === "🕺🏻"));
});
