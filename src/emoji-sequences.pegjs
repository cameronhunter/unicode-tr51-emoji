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
  = (DefinitionV2 / DefinitionV3 / DefinitionV4)
  / (Comment / BlankLine) { return null }

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
 * code_point(s) ; type_field # version [count] name(s)
 **************************************************************************************************/

// TODO: Include description
DefinitionV3
  = codepoints:Codepoints _ ";" _ type:Text _ "#" _ version:Word _ Word _ Word _ (!"\n" .)* "\n"?
    { return Object.assign({ type, version }, codepoints) }

/***************************************************************************************************
 * Version 2.0
 *
 * Format:
 * codepoints ; # (sequence) description
 **************************************************************************************************/

// TODO: Include description
DefinitionV2
  = codepoints:Codepoints _ "#" _ (!"\n" .)* "\n"?
    { return codepoints }

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
