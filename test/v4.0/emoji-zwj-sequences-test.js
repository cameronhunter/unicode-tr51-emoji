import test from "ava";
import sequences from "../../v4.0/emoji-zwj-sequences";

test("contains woman technologist: dark skin tone", t => {
  t.truthy(sequences.find((item) => item.symbol === "👩🏿‍💻"));
});
