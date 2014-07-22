---
layout: post
title: Personal cheatsheet
permalink: personal-cheatsheet
tags:
- cheatsheet
- git
- vim
- scp
- sshfs
- agisoft
- photoscan
- python
- argparse
---

Herein lies my personal cheatsheet for all things I find useful and wish not to forget.

## Git

These are the things you need to do when using `git` on a new computer:

{% highlight bash lineanchors %}
# Change username associated with commits
git config --global user.name "<USER>"

# Change email associated with commits
git config --global user.email <EMAIL>

# Cache uname and passwd for convenience (only on git >= 1.7.9)
git config --global credential.helper cache
{% endhighlight %}

## Vim

### Editing over scp

Vim comes with the ability to edit files remotely over scp. This can be achieved via:

{% highlight vim lineanchors %}
vim scp://user@servername//path/to/file
{% endhighlight %}

However, trying to save gives the error:

{% highlight vim lineanchors %}
E382: Cannot write, 'buftype' option is set
{% endhighlight %}

In fact, running `set buftype?` reveals that `buftype` is set to `nofile`, meaning the buffer cannot be saved to file.

This can be circumvented by clearing `buftype`, as is the default with local file editing:

{% highlight vim lineanchors %}
:set buftype=
:w
{% endhighlight %}

However, the buffer returns back to it's initial state of being set to `nofile`. It is therefore useful to define a function in `~/.vimrc` to save you the typing to do both in one go:

{% highlight vim lineanchors %}
function RemoteSave ()
    set buftype=
    write
endfunction
{% endhighlight %}

This simple function allows you to write to the remote file via `scp` each time with one single command:

{% highlight vim lineanchors %}
:call RemoteSave()
{% endhighlight %}

<br>Update</br>
Whilst this is still useful cheatsheet information on how to make Vimscript functions, the [netrw plugin](http://www.vim.org/scripts/script.php?script_id=1075) that comes bundled with Vim 7.0 comes with a build-in function to do exactly this, with only one command:

{% highlight vim lineanchors %}
:Nwrite
{% endhighlight %}

## sshfs

To allow other non-root users to access a filesystem mounted over ssh, use:

{% highlight bash lineanchors %}
sshfs -o allow_other user@servername:/path/to/content /path/to/local/mountpoint
{% endhighlight %}

## Photoshop

Whilst I don't generally like expensive proprietary software, particularly photoshop, given the importance of this small technique to my current project (on which I will write a full post soon), I felt it important to include how to mask parts of photos in Photoshop, ready to be imported into programs like [Photoscan](http://www.agisoft.ru/products/photoscan) (another piece of incredibly expensive proprietary software).

1. Firstly, select the region you want to mask (or keep unmasked, whichever is easier). The `w` key switches between the Quick Selection and Magic Wand tools, both useful in their own rights.

2. Next, in the "*Channels*" group, click "*New channel*" at the bottom of the group box. The image should now turn black.

3. If you want to mask the selection, press `<CMD><SHIFT>I` to invert the selection and press `<SHIFT><F5>`; select "*White*" and press `<CR>`. If you want to mask everything apart from the selection, then simply press `<SHIFT><F5>`, select "*White*" and press `<CR>`

4. Save the file as a format supporting alpha channels by pressing `<CMD><SHIFT>S`. For Photoscan imports, `TIFF` is recommended. Tick the box called "*Alpha Channels*" and press `<CR>` twice to save.

5. (**optional**) In Photoscan, after loading the photos into the workspace with *Workflow*>*Add photos*/*Add folder*, click *Tools*>*Import*>*Import masks...*. Make sure that "*Method*" is set to "*From Alpha*" and click okay. The masked areas will then be darkened to indicate they are masked.

**Bonus Tip:** To import masks from one photo into another, simpler drag the channel onto the new photo.

Note that this is based on the ancient CS3 that's installed on the Mac I'm currently using, and may not apply to newer versions.

## Python

### argparse

Skeleton `argparse` template:

{% highlight python lineanchors %}
# Import the library
import argparse

# Description of the program
parser = argparse.ArgumentParser(description="Short description of the Python program.")

# A compulsory positional argument
parser.add_argument("compulsory", help="Description of argument, what it does and what the options are.")

# A required normal argument
parser.add_argument("-o", "--option", required=True, help="Short description")

# An optional true/false argument
parser.add_argument("-v", "--verbose", action="store_true", help="Short description")

# Specifying the type
parser.add_argument("-f", "--float", type=float, help="Short description")

# Specifying the default value
parser.add_argument("-n", "--name", default="drew", help="Short description")

# Parse the arguments
args = parser.parse_args()

# Accessing the values of the arguments
myArgument = args.compulsory
myName = args.name
{% endhighlight %}
