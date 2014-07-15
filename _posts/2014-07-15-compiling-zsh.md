---
layout: post
title: Compiling `zsh` Without Root
---

This article describes how to compile zshell on a Linux machine without root, for instance when working remotely on a server on which you do not have root.

## Step 1: Dependencies

To compile `zsh`, you need `ncurses`. This needs to be compiled with the flag `-fPIC`. This can be achieved as follows:

{% highlight bash %}
# Download the ncurses gzipped tarball
wget ftp://invisible-island.net/ncurses/ncurses.tar.gz

# Extract gzipped tarball
tar -zxvf ncurses.tar.gz

# Move into root ncurses source directory
cd ncurses

# Set cflags and c++ flags to compile with Position Independent Code enabled
export CXXFLAGS=' -fPIC'
export CFLAGS=' -fPIC'

# Produce Makefile and config.h via config.status
./configure --prefix=$HOME/.local --enable-shared

# Compile
make

# Install
make install
{% endhighlight %}

Note that the `--enable-shared` configure flag ensures that libtool builds shared libraries for ncurses, needed for `zsh` later on.

## Step 2: Tell environment where ncurses is
Before compiling `zsh`, you need to tell your environment where your newly compiled files are (if you haven't already). This can be achieved with:

{% highlight bash %}
INSTALl_PATH='$HOME/.local'

export PATH=$INSTALL_PATH/bin/:$PATH
export LD_LIBRARY_PATH=$INSTALL_PATH/lib:$LD_LIBRARY_PATH
export CFLAGS=-I$INSTALL_PATH/include
export CPPFLAGS="-I$INSTALLATION_PATH/include"
export LDFLAGS="-L$INSTALLATION_PATH/lib"
{% endhighlight %}

## Step 3: Compiling `zsh`

Now, we're finally ready to move onto compiling `zsh`:

{% highlight bash %}
# Clone zsh repository from git
git clone git://github.com/zsh-users/zsh.git

# Move into root zsh source directory
cd zsh

# Produce config.h.in, needed to produce config.status from ./configure
autoheader

# Produce the configure file from aclocal.m4 and configure.ac
autoconf

# Produce Makefile and config.h via config.status
./configure --prefix=$HOME/.local --enable-shared

# Compile
make

# Install
make install
{% endhighlight %}

## Step 4: Enjoy `zsh`!
After these steps have been completed, zsh should be ready and compiled to use in your ~/.local/bin folder. If you like `zsh`, you'll love `ohmyzsh`. This can be installed by:

{% highlight bash %}
curl -L http://install.ohmyz.sh | sh
{% endhighlight %}

Or if you don't want o execute shell scripts from arbitrary non-https website, you can use git:

{% highlight bash %}
# Clone repository into local dotfiles
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

# Copy template file into home directory
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
{% endhighlight %}

Once you've done this, edit oh-my-zsh to your needs, e.g.

{% highlight bash %}
# Change your theme to your preference, I enjoy jonathan
echo "ZSH_THEME=jonathan" >> ~/.zshrc
{% endhighlight %}

And finally, change your shell to `zsh`:

{% highlight bash %}
chsh -s $HOME/.local/bin/zsh
{% endhighlight %}

Now sit back and enjoy your effortless tab completion, directory movement and integrated git information.

## Sources of information:
https://unix.stackexchange.com/questions/123597/building-zsh-without-admin-priv-no-terminal-handling-library-found

https://en.wikipedia.org/wiki/GNU_build_system#mediaviewer/File:Autoconf-automake-process.svg

https://github.com/zsh-users/zsh/blob/master/INSTALL
