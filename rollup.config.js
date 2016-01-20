import babel from "rollup-plugin-babel";
import pegjs from "rollup-plugin-pegjs";

export default {
  entry: "src/grammar.pegjs",
  dest: "parser/index.js",
  format: "cjs",
  plugins: [
    pegjs(),
    babel()
  ]
}
