import test from "ava";
import data from "../../v4.0";

test("Expected data", t => {
  t.snapshot(data);
});
