import test from "ava";
import sequences from "../../v3.0/emoji-zwj-sequences";

test("contains couple with heart: WOMAN, WOMAN", t => {
  t.truthy(sequences.find((item) => item.symbol === "👩‍❤️‍👩"));
});
