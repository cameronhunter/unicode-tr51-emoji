import test from "ava";
import sequences from "../../v2.0/emoji-zwj-sequences";

test("contains man, zwj, heavy black heart, zwj, man", t => {
  t.truthy(sequences.find((item) => item.symbol === "👨‍❤‍👨"));
});
