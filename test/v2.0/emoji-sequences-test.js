import test from "ava";
import sequences from "../../v2.0/emoji-sequences";

test("contains flag of United Kingdom", t => {
  t.truthy(sequences.find((item) => item.symbol === "🇬🇧"));
});
