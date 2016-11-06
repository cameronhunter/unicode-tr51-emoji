import babel from "rollup-plugin-babel";
import pegjs from "rollup-plugin-pegjs";

export default {
  format: "cjs",
  plugins: [
    pegjs(),
    babel()
  ]
}
