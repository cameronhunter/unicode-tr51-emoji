import test from "ava";
import data from "../../v1.0";

test("Expected data", t => {
  t.snapshot(data);
});
