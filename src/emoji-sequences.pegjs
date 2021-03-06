{
  const escape = require("jsesc");

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
   { return lines.filter(Boolean).reduce((result, c) => [...result, c], []) }

Line
  = (DefinitionV2 / DefinitionV3 / DefinitionV4 / DefinitionV5)
  / (Comment / BlankLine) { return null }

/***************************************************************************************************
 * Version 5.0
 *
 * Format:
 * code_point(s) ; type_field ; # (version) description
 **************************************************************************************************/

DefinitionV5
  = codepoints:Codepoints _ ";" _ type:$(("text" / "emoji") _ "style") _ ";" _ "#" _ "(" version:$([1-9][0-9]* "." [0-9]+) ")" _ description:(!"\n" char:. { return char })* "\n"?
    { return Object.assign({ description: description.join(''), type, version }, codepoints) }

/***************************************************************************************************
 * Version 4.0
 *
 * Format:
 * code_point(s) ; type_field ; description # comments
 **************************************************************************************************/

DefinitionV4
  = codepoints:Codepoints _ ";" _ type:Text _ ";" _ description:Description _ "#" _ version:Word _ (!"\n" .)* "\n"?
    { return Object.assign({ description, type, version }, codepoints) }

/***************************************************************************************************
 * Version 3.0
 *
 * Format:
 * code_point(s) ; type_field # version [count] (sequence) name(s)
 **************************************************************************************************/

DefinitionV3
  = codepoints:Codepoints _ ";" _ type:Text _ "#" _ version:Word _ (count:Word _ symbol:Word)? _ description:(!"\n" char:. { return char })* "\n"?
    { return Object.assign({ description: description.join(''), type, version }, codepoints) }

/***************************************************************************************************
 * Version 2.0
 *
 * Format:
 * codepoints ; # (sequence) description
 **************************************************************************************************/

DefinitionV2
  = codepoints:Codepoints _ "#" _ symbol:Word _ description:(!"\n" char:. { return char })* "\n"?
    { return Object.assign({ description: description.join('') }, codepoints) }

/***************************************************************************************************
 * Common
 **************************************************************************************************/

Codepoints
  = head:Codepoint tail:(" " codepoint:Codepoint { return codepoint })*
    { return details(head, ...tail) }

Codepoint
  = $([0-9A-F]i+)

Description
  = head:Word tail:(" " second:Word { return " " + second })*
    { return [head, ...tail].join('') }

Word
  = $([^ ]+)

Comment
  = "#" comment:$([^\n]*) _ "\n"?
    { return comment.trim() }

Text
  = $([a-z_0-9.]i+)

BlankLine
  = _ "\n"
    { return "" }

_ "whitespace"
  = ws:[ \t]*
    { return ws.join('') }
