# unicode-tr51-emoji

[![Build Status](https://travis-ci.org/cameronhunter/unicode-tr51-emoji.svg?branch=master)](https://travis-ci.org/cameronhunter/unicode-tr51-emoji) [![NPM Version](https://img.shields.io/npm/v/unicode-tr51-emoji.svg)](https://npmjs.org/package/unicode-tr51-emoji) [![License](https://img.shields.io/npm/l/unicode-tr51-emoji.svg)](https://github.com/cameronhunter/unicode-tr51-emoji/blob/master/LICENSE.md)

This package enables an easy way of getting the list of all emoji symbols (in string or code point format) in your JavaScript build scripts. It is inspired by Mathias Bynens's [unicode-tr51](https://github.com/mathiasbynens/unicode-tr51).

## Installation

Via [npm](https://www.npmjs.com/):

```bash
npm install unicode-tr51-emoji
```

In [Node.js](https://nodejs.org/):

```js
const codepoints = require('unicode-tr51-emoji/code-points');
const symbols = require('unicode-tr51-emoji/symbols');

const emojiData = require('unicode-tr51-emoji/emoji-data');
const emojiSequences = require('unicode-tr51-emoji/emoji-sequences');
const emojiZWJSequences = require('unicode-tr51-emoji/emoji-zwj-sequences');
```

By default it returns the latest version (v5.0), you can access particular versions directly using:

```js
const codepoints = require('unicode-tr51-emoji/v3.0/code-points');
const symbols = require('unicode-tr51-emoji/v3.0/symbols');

// v3.0 (http://www.unicode.org/Public/emoji/3.0/emoji-data.txt)
const emojiData = require('unicode-tr51-emoji/v3.0/emoji-data');

// v3.0 (http://www.unicode.org/Public/emoji/3.0/emoji-sequences.txt)
const emojiSequences = require('unicode-tr51-emoji/v3.0/emoji-sequences');

// v3.0 (http://www.unicode.org/Public/emoji/3.0/emoji-zwj-sequences.txt)
const emojiZWJSequences = require('unicode-tr51-emoji/v3.0/emoji-zwj-sequences');
```
