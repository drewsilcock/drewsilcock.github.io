---
layout: post
title: Using make for easy LaTeX compilation
permalink: using-make-for-latex
categories: coding
live: false
---

Still running `pdflatex` (or equivalent) every time you want to recompile your \\( \\LaTeX \\) document? There's a simpler way using `make` and `latexmk`. All you need is a simple `Makefile` and you can tell \\( \\LaTeX \\) to automatically recompile your document every time you change a file, and run `pdflatex` the sufficient number of times to get cross-references right.

<!--more-->

So I recently discovered `latexmk`, a utility that simplifies \\( \\LaTeX \\) compilation by automatically rerunning whatever compilation command you use to compile your documents (i.e. `pdflatex`, `xelatex` or whatever) the sufficient number of times in order to make sure cross-references resolve themselves fully.This in itself is super useful, but you can leverage the power of GNU `make` in addition to this to make compilation easy, continual and targeted only at changed files.

For the purposes of this article, I assume that you're using `pdflatex`, but all of this equally applies to `xelatex` or similar by simply replacing the `pdflatex` command with whichever you use.

## latexmk

The basic syntax of `latexmk` is as follows:

{% highlight bash lineacnhors %}
$ latexmk $OPTIONS -pdflatex="$COMPILATION_COMMAND $PDFLATEX_OPTIONS %O %S" yourtexfile.tex
{% endhighlight %}

Note that `%O` is replaced by `latexmk` with the options given to `latexmk`, and `%S` is replaced with the source file name, in this example `yourtexfile.tex`. Some useful options to give to `latexmk` include `-pdf`, which tells `latexmk` that your final produced document is a `pdf`, and `-pvc`, which will be discussed shortly. `latexmk` also summarises the errors and warnings incurred throughout the compilation, which is very useful considering they're usually lost in a sea of output during normal `pdflatex` compilation.

This will automatically run `pdflatex` enough times to get those references resolved. But we can make this even more useful using the `pdflatex` option, `--interaction=nonstopmode`. This means that `pdflatex` automatically goes through the compilation, not requiring any user input. This importantly means that it goes right through any errors, not requiring the user to type `X` in to quit the compilation on error.

The next useful option to pass to `latexmk` in combination with this is `-pvc`. It's purpose is to run continuously, and update your pdf viewer every time it updates your document.

## make

Finally, we can wrap all this in a `Makefile` so we don't have to type the long `latexmk` command in, and to detect changes in files so you're not recompiling your file on no change.

Here's a basic template for using `make` to simply this whole thing:

{% highlight makefile lineanchors %}
LATEX=pdflatex
LATEXOPT=--shell-escape --interaction=nonstopmode

LATEXMK=latexmk
LATEXMKOPT=-pcv -pdf

MAIN=yourtexfile
SOURCES=$(MAIN).tex Makefile yourothertexfiles
FIGURES := $(shell find figures/* images/* -type f)

all:    $(MAIN).pdf

.refresh:
    touch .refresh

$(MAIN).pdf: $(MAIN).tex .refresh $(SOURCES) $(FIGURES)
        $(LATEXMK) $(LATEXMKOPT) -pdflatex="$(LATEX) $(LATEXOPT) %O %S" $(MAIN).tex

force:
        touch .refresh
        $(MAKE) $(MAIN).pdf

.PHONY: clean force all

clean:
        $(LATEXMK) -C $(MAIN).tex
        rm -f $(MAIN).tex
        rm -rf *~ *.tmp
        rm -f *.bbl *.blg *.aux *.end *.fls *.log *.out *.fdb_latexmk
{% endhighlight %}
