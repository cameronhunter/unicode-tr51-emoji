import test from "ava";
import data from "../../v3.0";

test("Expected data", t => {
  t.snapshot(data);
});
