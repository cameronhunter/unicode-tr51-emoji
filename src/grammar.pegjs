{
  const codepoints = (codepoint) => {
    const symbol = String.fromCodePoint(parseInt(codepoint, 16));
    const bytes = symbol.split("").map(c => `\\u${c.charCodeAt(0).toString(16)}`).join("");
    return { symbol, codepoints: bytes };
  }
}

File
 = lines:Line*
   { return lines.filter(line => !!line) }

Line
  = (DefinitionV1 / DefinitionV2)
  / (Comment / BlankLine) { return null }

/***************************************************************************************************
 * Version 2.0
 *
 * Format:
 * codepoint(s) ; property=Yes # [count] (character(s)) name
 **************************************************************************************************/

DefinitionV2
  = codepoints:Codepoints _ ";" _ property:Text _ comment:Comment _ "\n"?
    { return { codepoints } }

/***************************************************************************************************
 * Version 1.0
 *
 * Format:
 * Code ; Default_Emoji_Style ; Emoji_Level ; Emoji_Modifier_Status ; Emoji_Sources # Comment
 **************************************************************************************************/

DefinitionV1
  = codepoints:Codepoints _ ";" _ style:Text _ ";" _ level:Text _ ";" _ modifier:Text _ ";" _ sources:Sources _ comment:Comment _ "\n"?
    { return { codepoints } }

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
    { return codepoints(text) }

Codepoints
  = start:Codepoint (".." / _) end:Codepoint
    { return [start, end] }
  / codepoint:Codepoint
    { return [codepoint] }

Comment
  = "#" comment:$([^\n]*) _ "\n"?
    { return comment.trim() }

Text
  = $([a-z_0-9]i+)

BlankLine
  = _ "\n"
    { return "" }

_ "whitespace"
  = [ \t]*
