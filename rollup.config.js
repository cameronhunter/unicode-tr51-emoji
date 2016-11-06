import babel from "rollup-plugin-babel";
import pegjs from "rollup-plugin-pegjs";

export default {
  entry: "src/emoji-data.pegjs",
  dest: "parser/emoji-data.js",
  format: "cjs",
  plugins: [
    pegjs(),
    babel()
  ]
}
