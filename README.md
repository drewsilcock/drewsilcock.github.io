drewsilcock.co.uk
=================

This is the source code for my personal website. It uses the [Lanyon](lanyon.getpoole.com) theme for [Poole](getpoole.com), which in turn is based on [Jekyll](jekyllrb.com), a powerful static-site generator.

Requirements
------------

You need `ruby`, `jekyll`, `node`, `java` and the gems in `Gemfile`, which can be installed with a simple `bundle install` (requires `bundler`).

On Ubuntu:

```bash
> sudo apt-get install ruby-dev

> sudo apt-get install bundler

> bundle install

> sudo apt-get install nodejs && sudo ln -s /usr/bin/node /usr/bin/nodejs

> sudo apt-get install default-jre default-jdk
```

Installation
------------

To install this website locally, just run:

```bash
> git clone https://github.com/drewsberry/drewsberry.github.io.git

> cd drewsberry.github.io

> bundle install

> bundle exec jekyll serve --watch
```

Now you've got it up and running at port 4000! Note that you might have to manually rerun `jekyll build` if you want to make changes to `_config.yml`.

The way I use git for my version control of my website, alongside GitHub pages, means I do the following:

```bash
> git clone https://github.com/drewsberry/drewsberry.github.io.git

> cd drewsberry.github.io

> git checkout source

> git clone https://github.com/drewsberry/drewsberry.github.io.git _site

> bundle install

> bundle exec jekyll serve --watch
```

So that when I want to compile the site and push the compiled `_site` directory to GitHub pages, I run (in the root of the repo):

```bash
> git checkout source

> bundle exec jekyll build

> cd _site

> git checkout master

> git commit -am "Update website"

> cd ..
```

Copyright
---------

Feel free to use any of this code for your own personal use, and if you want to reproduce anything from any of my posts, either send me an email asking for permission or link the post up on your page (they're permalinked).
