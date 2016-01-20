# unicode-tr51-emoji

[![Build Status](https://travis-ci.org/cameronhunter/unicode-tr51-emoji.svg?branch=master)](https://travis-ci.org/cameronhunter/unicode-tr51-emoji) [![NPM Version](https://img.shields.io/npm/v/unicode-tr51-emoji.svg)](https://npmjs.org/package/unicode-tr51-emoji) [![License](https://img.shields.io/npm/l/unicode-tr51-emoji.svg)](https://github.com/cameronhunter/unicode-tr51-emoji/blob/master/LICENSE.md)

This package enables an easy way of getting the list of all emoji symbols (in string or code point format) in your JavaScript build scripts. It is inspired by (and API compatible) with Mathias Bynens's [unicode-tr51](https://github.com/mathiasbynens/unicode-tr51).

## Installation

Via [npm](https://www.npmjs.com/):

```bash
npm install unicode-tr51-emoji
```

In [Node.js](https://nodejs.org/):

```js
var codepoints = require('unicode-tr51-emoji/code-points');
var symbols = require('unicode-tr51-emoji/symbols');
```

By default it returns the latest version (v2.0), you can access particular versions directly using:

```js
// v1.0 (http://www.unicode.org/Public/emoji/1.0/emoji-data.txt)
var codepoints = require('unicode-tr51-emoji/code-points');
var symbols = require('unicode-tr51-emoji/symbols');

// v2.0 (http://www.unicode.org/Public/emoji/2.0/emoji-data.txt)
var codepoints = require('unicode-tr51-emoji/code-points');
var symbols = require('unicode-tr51-emoji/symbols');
```
