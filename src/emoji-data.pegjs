{
  const escape = require("jsesc");

  const range = (...args) => {
    const [start, end] = args.map(c => parseInt(c, 16));
    return [...Array((end + 1) - start)].map((_, i) => start + i).map(d => d.toString(16));
  }

  const details = (...args) => {
    const codepoints = args.map(c => parseInt(c, 16));
    const symbol = String.fromCodePoint(...codepoints);
    const unicode = args.map(c => `U+${c}`.toUpperCase());
    const escaped = symbol.split("").map(c => escape(c))
    return { symbol, unicode, codepoints, escaped };
  }
}

File
 = lines:Line*
   { return lines.filter(Boolean).reduce((result, c) => Array.isArray(c) ? [...result, ...c] : [...result, c], []) }

Line
  = (DefinitionV1 / DefinitionV2 / DefinitionV3to4)
  / (Comment / BlankLine) { return null }

/***************************************************************************************************
 * Version 3.0 – 4.0
 *
 * Format:
 * codepoint(s) ; property(=Yes) # version [count] name(s)
 **************************************************************************************************/

DefinitionV3to4
  = codepoints:Codepoints _ ";" _ type:Word _ "#" _ version:Version _ count:Count _ symbol:Word _ description:(!"\n" char:. { return char })* "\n"?
    { return Array.isArray(codepoints) ? codepoints.map(c => Object.assign({ type, version }, c)) : Object.assign({ description: description.join(''), type, version }, codepoints) }

/***************************************************************************************************
 * Version 2.0
 *
 * Format:
 * codepoint(s) ; property=Yes # [count] (character(s)) name
 **************************************************************************************************/

DefinitionV2
  = codepoints:Codepoints _ ";" _ type:Word _ "#" _ count:Count _ symbols:Word _ description:(!"\n" char:. { return char })* "\n"?
    { return Array.isArray(codepoints) ? codepoints.map(c => Object.assign({ type }, c)) : Object.assign({ description: description.join(''), type }, codepoints) }

/***************************************************************************************************
 * Version 1.0
 *
 * Format:
 * Code ; Default_Emoji_Style ; Emoji_Level ; Emoji_Modifier_Status ; Emoji_Sources # Comment
 **************************************************************************************************/

DefinitionV1
  = codepoints:Codepoints _ ";" _ style:Word _ ";" _ level:Word _ ";" _ modifier:Word _ ";" _ sources:Sources _ "#" _ version:Version _ symbol:Word _ description:(!"\n" char:. { return char })* "\n"?
    { return Object.assign({ description: description.join(''), version }, codepoints) }

Source
  = $([ajwxz])

Sources
  = head:Source tail:(_ source:Source { return source; })*
    { return [head, ...tail] }

/***************************************************************************************************
 * Common
 **************************************************************************************************/

Codepoint
  = text:$([0-9A-F]+)

Codepoints
  = start:Codepoint ".." end:Codepoint
    { return range(start, end).map(c => details(c)) }
  / head:Codepoint tail:(_ codepoint:Codepoint { return codepoint })*
    { return details(head, ...tail) }

Word
  = $([^ ]+)

Comment
  = "#" comment:$([^\n]*) _ "\n"?
    { return comment.trim() }

Count
  = "[" head:[0-9] tail:$([0-9])* "]"
    { return parseInt([head, ...tail].join(''), 10) }

Version
  = "V"? version:$([0-9]+ "." [0-9])
    { return version }

Text
  = $([a-z_0-9.]i+)

BlankLine
  = _ "\n"
    { return "" }

_ "whitespace"
  = [ \t]*
