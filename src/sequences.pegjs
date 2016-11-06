{
  const details = (...args) => {
    const codepoints = args.map(c => parseInt(c, 16));
    const symbol = String.fromCodePoint(...codepoints);
    const unicode = args.map(c => `U+${c}`.toUpperCase());
    return { symbol, unicode, codepoints };
  }
}

File
 = lines:Line*
   { return lines.filter(Boolean).reduce((result, c) => [...result, c], []) }

Line
  = (DefinitionV2 / DefinitionV3 / DefinitionV4)
  / (Comment / BlankLine) { return null }

DefinitionV4
  = sequence:Codepoints _ ";" _ type:Text _ ";" _ description:Description _ "#" _ version:Word _ (!"\n" .)* "\n"?
    { return { ...sequence, type, description, version } }

// TODO: Include description
DefinitionV3
  = sequence:Codepoints _ ";" _ type:Text _ "#" _ version:Word _ Word _ Word _ (!"\n" .)* "\n"?
    { return { ...sequence, type, version } }

// TODO: Include description
DefinitionV2
  = sequence:Codepoints _ "#" _ (!"\n" .)* "\n"?
    { return sequence }

Codepoints
  = head:Codepoint tail:(_ codepoint:Codepoint { return codepoint })*
    { return details(head, ...tail) }

Codepoint
  = text:$([0-9A-F]+)

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
