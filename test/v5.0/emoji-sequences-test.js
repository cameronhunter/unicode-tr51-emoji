import test from "ava";
import sequences from "../../v5.0/emoji-sequences";

test("contains flag of the United Nations", t => {
  t.truthy(sequences.find((item) => item.symbol === "🇺🇳"));
});
