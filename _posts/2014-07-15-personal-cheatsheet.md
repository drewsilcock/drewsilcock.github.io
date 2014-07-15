---
layout: post
title: Personal Cheatsheet
---

Herein lies my personal cheatsheet for all things I find useful and wish not to forget.

# Git

These are the things you need to do when using `git` on a new computer:

{% highlight bash %}
# Change username associated with commits
git config --global user.name "<USER>"

# Change email associated with commits
git config --global user.email <EMAIL>

# Cache uname and passwd for convenience (only on git >= 1.7.9)
git config --global credential.helper cache
{% endhighlight %}

# Vim

## Editing over scp

Vim comes with the ability to edit files remotely over scp. This can be achieved via:

{% highlight vim %}
vim scp://user@servername//path/to/file
{% endhighlight %}

However, trying to save gives the error:

{% highlight vim %}
E382: Cannot write, 'buftype' option is set
{% endhighlight %}

In fact, running `set buftype?` reveals that `buftype` is set to `nofile`, meaning the buffer cannot be saved to file.

This can be circumvented by clearing `buftype`, as is the default with local file editing:

{% highlight vim %}
:set buftype=
:w
{% endhighlight %}

However, the buffer returns back to it's initial state of being set to `nofile`. It is therefore useful to define a function in `~/.vimrc` to save you the typing to do both in one go:

{% highlight vim %}
function RemoteSave ()
    set buftype=
    write
endfunction
{% endhighlight %}

This simple function allows you to write to the remote file via `scp` each time with one single command:

{% highlight vim %}
:call RemoteSave()
{% endhighlight %}
