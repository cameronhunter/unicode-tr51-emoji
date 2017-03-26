import test from "ava";
import data from "../../v2.0";

test("Expected data", t => {
  t.snapshot(data);
});
