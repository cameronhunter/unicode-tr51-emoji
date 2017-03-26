import test from "ava";
import data from "../../v5.0";

test("Expected data", t => {
  t.snapshot(data);
});
