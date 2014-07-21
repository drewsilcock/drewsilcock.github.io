---
layout: post
title: Proper line numbers with Jekyll
permalink: proper-linenumbers
---

By default, Jekyll uses the (excellent) Pygments syntax highlighter for code blocks. While this works well, the line numbers it produces are less than satisfactory.

Here's the default `lineno` option, `inline`:

![lineno=inline](../public/media/lineno_w_inline.png)

This works, but has two main visual and practical problems:
    * There is no visual separation between the line numbers and the code, causing them to visually become indistinct, and
    * When trying to copy code from the codeblocks, the line numbers are included, annoyingly.


So what's the alternative? Well, Pygments has inbuilt the `table` option, which separates the code from the linenumbers, ostensibly fixing both of these problems. Let's take a look:

![lineno=table](../public/media/lineno_w_table.png)

Well, as you can see, this doesn't really look good either. The main problems areL=:
    * The size of the line number table is inconsistent between codeblocks, and
    * The line numbers don't align with the actual lines of code

So let's get rid of the `lineno` option altogether, and get our beautiful but functional line numbers through [CSS counters](https://developer.mozilla.org/en-US/docs/Web/Guide/CSS/Counters), as described in an article by [Alex Peattie](http://alexpeattie.com/blog/github-style-syntax-highlighting-with-pygments/).

## CSS File

Alex's CSS is as follows:

{% highlight css %}
pre {
    counter-reset: line-numbering;
    border: solid 1px #d9d9d9;
    border-radius: 0;
    background: #fff;
    padding: 0;
    line-height: 23px;
    margin-bottom: 30px;
    white-space: pre;
    overflow-x: auto;
    word-break: inherit;
    word-wrap: inherit;
}

pre a::before {
  content: counter(line-numbering);
  counter-increment: line-numbering;
  padding-right: 1em; /* space after numbers */
  width: 25px;
  text-align: right;
  opacity: 0.7;
  display: inline-block;
  color: #aaa;
  background: #eee;
  margin-right: 16px;
  padding: 2px 10px;
  font-size: 13px;
  -webkit-touch-callout: none;
  -webkit-user-select: none;
  -khtml-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
}

pre a:first-of-type::before {
  padding-top: 10px;
}

pre a:last-of-type::before {
  padding-bottom: 10px;
}

pre a:only-of-type::before {
  padding: 10px;
}
{% endhighlight %}

Here's what it produces:

![beautiful linenumbers](../public/media/lineno_beautiful.png)

Note those important lines at the end of `pre a::before`:

{% highlight css %}
  -webkit-touch-callout: none;
  -webkit-user-select: none;
  -khtml-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
{% endhighlight %}

This tell the browser to ignore the line numbers when copying, solving one of our initial problems.

In addition, the background grey of `#eee` gives the visual distinction between line numbers and code that we were lacking from `lineno=inline`. And, of course, they align properly with the actual lines of code, unlike `lineno=table`.

On top of this, the `padding` gives the line numbers a consistent spacing and the solid border given by `border: solid 1px #d9d9d9` gives the code a clear separation from the main text.

## Lineanchors

Problem: Line numbers now look silly

![without lineanchors](../public/media/lineno_wo_lineanchors.png)

Solution: Need lineanchors for our CSS to work

## Global plugin

Problem: need to put lineanchors for every single code block
Solution: global pygments config plugin
Problem 2: Github Pages doesn not allow custom plugins
Solution 2: Yet to be found

## Scroll bar

Problem: random y scroll bar

![annoying scroll bar](../public/media/lineno_w_yscroll.png)

Solution: in syntax.css, under pre { .. }, put overflow-y: hidden
