---
layout: post
title: How long is a cucumber? 🥒 
permalink: how-long-is-a-cucumber
comments: True
categories: coding
---

*Or: UTF16 handling of astral planes and implications for JavaScript string indexing*

**tldr**: 2.

String encoding in JavaScript is a bit weird. You might've heard this before. You might even have read about how, somewhat inexplicably, JavaScript does not use the almost universal UTF8 file encoding but instead UTF16<sup>\*</sup>. In this article I'm going to explore some of the more subtle and perplexing aspects of the weird way JavaScript encodes its strings, and what this means for common operations like string indexing.

## So what's all this Unicode stuff about then?

*(If you're already a Unicode wizard, go ahead and skip to the [next section](#so-what-does-this-have-to-do-with-javascript-and-cucumberscucumber).)*

Well, Unicode is a standard for defining characters like 'F', '♡' or '🥒 '. (if you all you see is a blank box for this, just mentally replace it with another character like ☸). The way it does this is by giving each character a corresponding ''code point'' which is a numerical value like `135` (which happens to be this character: ‡). Usually, this numerical value is represented hexademically, meaning ‡ corresponds to code point `0x87`.

The Unicode standard has a total of 1,114,112 code points, corresponding to 1,114,112 possible characters<sup>\*\*</sup>. That's a lot of characters. To split this up, this space is divided into 17 ''planes'', where each plane has 65,535 (or 2<sup>16</sup>) code points. The first plane, which contains most of the commonly used characters like ''9'', ''£'', ''ڞ'' and ''丧'', is called the Basic Multilingual Plane (or BMP). This contains all of ASCII and extended ASCII; African, Middle-Eastern and non-Latin European scripts; Chinese, Japanese and Korean characters (collectively referred to as CJK characters); private use and what are known as ''surrogate pairs''. I'll come onto what exactly surrogate pairs are used for a bit later.

Past this continent of common characters lies the vast, largely uninhabited and mysterious realms known as the 16 ''astral planes'' (or ''supplementary planes'', if you're being boring).

The BMP takes up the first 2<sup>16</sup> code points in the range `0x0000` to `0xffff`. This means that all BMP code points can be represented using only 16 bits or 2 bytes (some fewer). The astral planes, extending from `0x10000` to the full `0x10ffff`, need between 3 and 4 bytes to represent them.

![The 14<sup>th</sup> Century philosopher Nicole Oresmo's astral planes.](/public/media/how-long-is-a-cucumber/astral_planes.jpg)

> The 14<sup>th</sup> Century philosopher Nicole Oresmo demonstrates some astral plane characters. Images such as these would be distributed to the monks of the monasteries to aid their copying of Unicode manuscripts.

### So what does this have to do with JavaScript and cucumbers?

Well, among the vast expanse of astral code points lies the cucumber, code point `0x1f952`: 🥒 . Because the cucumber character is above the BMP, it needsmore than 16 bits to represent it. Yet, JavaScript uses UTF16 which encodes each character using only *16* bits, so how does this work?!

The truth is that UTF16 essentially uses two separate code points to represent this single character. This is where the ''surrogate'' code points that I mentioned earlier come in. Unicode reserves two blocks, the ''High Surrogates'': `0xd800` - `0xdbff` and the ''Low Surrogates'': `0xdc00` - `0xdfff`.

Each astral code point is represented in UTF16 as one Low Surrogate and one High Surrogate by the following equation:

{% highlight js lineanchors %}
0x1000016 + (high_surrogate − 0xd80016) × 0x40016 + (low_surrogate − 0xdc0016)
{% endhighlight %}

What this means is that, in JavaScript, the cucumber character `0x1f952` is represented as *two separate characters*: `55358` or `0xd83e` (the high surrogate) and `56658` or `0xdd52` (the low surrogate).

### Okay, so what does this mean for string indexing?

The astute reader may wonder what these surrogate pair representations of single characters means for the indexing of strings in JavaScript. When you have a string like `var s = "hello there"`, you expect `s[0]` to give you the first character, `s[3]` to give you the fourth character and `s[7]` to give you the eight character. But what about the following code:

{% highlight js lineanchors %}
var cucumber = "🥒";
console.log(cucumber.length);
// -> 2
{% endhighlight %}

So, even though it contains only a single character, JavaScript thinks that the cucumber string has a length of 2! We can delve a bit further:

{% highlight js lineanchors %}
var highSurrogate = cucumber[0];
var lowSurrogate = cucumber[1];

console.log(highSurrogate, highSurrogate.codePointAt());
// -> � 55358
console.log(lowSurrogate, lowSurrogate.codePointAt());
// -> � 56658
{% endhighlight %}

What this shows is that string indexing works by assuming that all characters are within the BMP, and so are exactly 16 bits long. So the indexing picks out not the entire cucumber character, but only one of its two surrogate pairs!

This means that the string indexing works the same way as classical C-like array indexing, where `s[4]` just means getting the address of `s` and skipping forward `4 * sizeof s[0]` bytes.

This maintains the O(1) speed of normal BMP string indexing, but is clearly bound to cause bugs when users are able to input astral characters into a script not expecting it! In fact, as I type out this article on http://dillinger.io, trying to remove an astral character with the ''Delete'' or ''Backspace'' buttons on a character like ''😊'' deletes not the character, but one of the *surrogates*, leaving the other surrogate as a weird question mark (�) which really confuses the cursor positioning...

(It's also a fun way to trick password forms into accepting fewer characters than they were asking for, like ''😂😼😊✌️'' which will trick JavaScript minimum character checks looking for a minimum of 8 characters.)

### What about this UTF-8 business then?

UTF-8 is a variable-length encoding, which means that there are no surrogate pairs and instead each character has a variable length; ASCII character are only 1 byte long, but the CJK characters are 2 bytes long. The astral code points extend to 3 and 4 bytes. What this means is that, whereas UTF16 tries (in vain) to maintain a 16-bit limit on characters, UTF8 characters are by design non-fixed size.

UTF-8 strings are always smaller (or same size as) UTF-16 or UTF-32 strings, which makes them the most compact Unicode encoding.

### So how do other languages handle Unicode?

Well, JavaScript isn't on its own:

- **C** - natively uses 8-bit `char` able to handle only the ASCII character set. C99 introduced `wchar_t` meaning a 16-bit wide characters able to handle all Unicode via the surrogate pair method used by JavaScript (just don't try to implement this yourself unless you are *really really* into this kind of thing).
- **C++** - natively uses 8-bit `std::string` much like pure C. There is `std::wstring` analogous to C's `wchar_t` with corresponding `std::wcout`, `std::wcerr`, etc.
- **Python** - I'm not going to open this can of worms. To summarise, Python supports the full Unicode range via either UTF-16 (as per JavaScript) or UCS-4 which is where each character is 32-bits long and you don't have to deal with any of this surrogate nonsense (although all your strings end of being *much* larger than they need to be).
- **Java** - Java's `char` type is 16-bit length able to store the BMP characters only. The `String` type uses UTF-16 to enable the full Unicode range as per JavaScript.

Then again, some of the newer languages seem to have seen the errors of the past and are adapting UTF-8 for strings natively:

- **Go** - Go source code is formatted as UTF-8. Strings are actually encoding-independent slices of bytes, however as Go source code is UTF-8 this practically means that almost all string literals are UTF-8. Indexing does *not*, however, index into the *runes* (i.e. visible characters) but the *bytes*. Bit weird, but there you go<sup>\*\*\*</sup>.
- **D** - has standard library support for UTF-8, UTF-16 *and* UTF-32 via `string`, `wstring` and `dstring` respectively, so you're spoilt for choice!
- **Rust** - uses UTF-8 strings as standard - Rust source code is UTF-8, string literals are UTF-8, the `std::string::String` encapsulates a UTF-8 string and primitive type `str` (the borrowed counterpart to `std::string::String`) is always valid UTF-8. Nice!

Check [this link](https://unicodebook.readthedocs.io/programming_languages.html) out for more information about how different programming languages handle Unicode.

### Bonus round: UTF8 string indexing in Rust

While languages like Go embrace UTF-8 but maintain indexing into bytes as the default, Rust goes further in making string indexing work on *runes* instead of bytes.

This means that Rust eschews the traditional string O(1) indexing. The pro of this is that you get out of it what you actually *want*, which is the n<sup>th</sup> visible rune instead of the n<sup>th</sup> byte or 16-bit char. The con is that we lose our O(1) speed string indexing as we now have to look through each previous character to check the length before we get to our rune at n, making lookup O(n).

![A comparison of how UTF16 and UTF8 index strings.](/public/media/how-long-is-a-cucumber/string_encoding_visual.png)

> A visualisation of how UTF16 constructs strings compared to UTF8. The resulting UTF8 string is shorter, but indexing is not O(n) (as opposed to O(1)) due to the multi-byte nature of the UTF8 character.

### Aside: private use in Unicode

What do you see when you look at the following symbol: ''?

Some people will see a weird 'p'-like symbol. On Linux, you might see a tiny Tux, the friendly Linux mascot: ![Tux](https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Tux_Mono.svg/149px-Tux_Mono.svg.png)

That's because it's part of the "Private Use Areas" of the Unicode standard. This means that these codepoints, *by definition*, will never have any characters assigned to them by the Unicode Consortium.

<sup>\*</sup> Technically, the [ECMAScript 5 specification](http://es5.github.io/x2.html#x2) with which JavaScript is compliant specifies *either* UCS-2 *or* UTF16 for string encoding, but we won't delve into this too much here. For more information on this subtle distinction, go read [this article](https://mathiasbynens.be/notes/javascript-encoding), it's really interesting if you're into your encoding.

<sup>\*\*</sup> In fact, the actual number of characters is significantly less than this for a few reasons:

* 137,468 code points are for ''private use'', meaning they will by definition never be assigned values by the Unicode Consortium.
* 2,048 code points are used as ''surrogates''. I'll discuss surrogates when it comes to UTF16 in JavaScript later in this article.
* 66 code points are specified as non-characters and used internally by programs. For example, the assigned non-character `0xFFFE` is used by programs to check whether they've got the endianness of a text file right, because the endian complement to `0xFFFE` is `0xFEFF`, which is the Byte Order Mark (BOM). If a program encounters `0xFFFE` at the start of a file, they it knows that they've got the endianess the wrong way around, because `0xFFFE` is *guaranteed* not to be used by the file as a character.

<sup>\*\*\*</sup>See https://blog.golang.org/strings for more information on strings in Go.

