---
layout: post
title: Proper line numbers with Jekyll
permalink: proper-linenumbers
---

By default, Jekyll uses the (excellent) Pygments syntax highlighter for code blocks. While this works well, the line numbers it produces are less than satisfactory.

The default line numbers, `inline`, works, but has two main visual and practical problems:
    * There is no visual separation between the line numbers and the code, causing them to visually become indistinct, and
    * When trying to copy code from the codeblocks, the line numbers are included, annoyingly.

> Picture of inline

What is wrong with table

> Picture of table

## CSS File

Problem: we need pretty line numbers
Solution: This guy's CSS file I'll link up

## Lineanchors

Problem: Line numbers now look silly

> Picture of without lineanchors

Solution: Need lineanchors for our CSS to work

## Global plugin

Problem: need to put lineanchors for every single code block
Solution: global pygments config plugin
Problem 2: Github Pages doesn not allow custom plugins
Solution 2: Yet to be found

## Scroll bar

Problem: random y scroll bar

> Picture of Silly scroll bar messing stuff up

Solution: in syntax.css, under pre { .. }, put overflow-y: hidden
