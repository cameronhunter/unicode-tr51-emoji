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
   { return lines.filter(line => !!line).reduce((result, c) => [...result, ...c]) }

Line
  = (DefinitionV1 / DefinitionV2 / DefinitionV3)
  / (Comment / BlankLine) { return null }

/***************************************************************************************************
 * Version 4.0
 *
 * Format:
 * codepoint(s) ; property(=Yes) # version [count] name(s)
 **************************************************************************************************/

DefinitionV4
  = DefinitionV3

/***************************************************************************************************
 * Version 3.0
 *
 * Format:
 * codepoint(s) ; property(=Yes) # version [count] name(s)
 **************************************************************************************************/

DefinitionV3
  = codepoints:Codepoints _ ";" _ property:Text _ "#" _ version:Text _ comment:Comment _ "\n"?
    { return codepoints }

/***************************************************************************************************
 * Version 2.0
 *
 * Format:
 * codepoint(s) ; property=Yes # [count] (character(s)) name
 **************************************************************************************************/

DefinitionV2
  = codepoints:Codepoints _ ";" _ property:Text _ comment:Comment _ "\n"?
    { return codepoints }

/***************************************************************************************************
 * Version 1.0
 *
 * Format:
 * Code ; Default_Emoji_Style ; Emoji_Level ; Emoji_Modifier_Status ; Emoji_Sources # Comment
 **************************************************************************************************/

DefinitionV1
  = codepoints:Codepoints _ ";" _ style:Text _ ";" _ level:Text _ ";" _ modifier:Text _ ";" _ sources:Sources _ comment:Comment _ "\n"?
    { return codepoints }

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
  / first:Codepoint _ second:Codepoint
    { return [details(first, second)] }
  / codepoint:Codepoint
    { return [details(codepoint)] }

Comment
  = "#" comment:$([^\n]*) _ "\n"?
    { return comment.trim() }

Text
  = $([a-z_0-9.]i+)

BlankLine
  = _ "\n"
    { return "" }

_ "whitespace"
  = [ \t]*
