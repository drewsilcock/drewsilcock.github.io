---
layout: post
title: katexify - a KaTeX Jekyll plugin
permalink: katexify
comments: True
categories: coding
live: false
---

If you follow [Hacker News](https://news.ycombinator.com/item?id=8320439), then you might've seen the latest development from Khan Academy: [{% latex %} \KaTeX {% endlatex %}](http://khan.github.io/KaTeX/).

{% latex %} \KaTeX {% endlatex %} is a replacement for the very popular and very slow MathJax, which although it has not fully implemented all the different symbols, promises to serve as a fully featured alternative.

This post presents a Jekyll plugin to render all your {% latex %} \LaTeX {% endlatex %} equations when you run `jekyll build`, so that all you need to do is bundle the {% latex %} \KaTeX {% endlatex %} CSS with your site and you've got lightning fast HTML mathematics.

<!--more-->

So why should you use {% latex %} \KaTeX {% endlatex %}? Well, here's a few reasons:

* [It's super fast](http://jsperf.com/katex-vs-mathjax);
* It supports server side rendering;
* Pure CSS (and JS if you're rendering client-side) - no external dependencies;
* It's *super* fast.

Going back to this second point, we can leverage server side rendering with the Jekyll plugin ecosystem.

So the first thing we need to do is

