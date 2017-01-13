---
layout: project
title: Hannah and Andrew's Wedding Site
project_url: https://www.hannahandandrewswedding.com
github_url: https://github.com/drewsberry/handy-pooper
summary: Hannah and Andrew's Wedding Site Description
---

This site provides information for Hannah Cooper and Andy Pike's wedding on June 17<sup>th</sup>.

## Libraries and Frameworks

The site uses the following frameworks and libraries:

* [jQuery](https://jquery.com/) - required for most of the following libraries and frameworks, and just makes things easier.
* [jQuery UI](https://jqueryui.com/) - provides additional easing functions, used when scrolling to a particular section.
* [Bootstrap](http://getbootstrap.com/) - for reusable compontents and CSS, e.g. navbar, grid system.
* [FlipClock.js](http://flipclockjs.com/) - for the countdown to the wedding.
* [Google Fonts](https://fonts.google.com/) - for the nice fonts.
* [Bootstrap Timeline](http://bootsnipp.com/snippets/featured/timeline-responsive) - for the timeline of the events of the day.
* [ScrollReveal.js](https://scrollrevealjs.org/) - for animating in elements when you scroll to them.
* [Google Maps JavaScript API](https://developers.google.com/maps/documentation/javascript/) - for the embedded map of where Farnham Castle is.
* [Font Awesome](http://fontawesome.io/) - for awesome font icons.
* [GitHub:buttons](https://buttons.github.io/) - for the ''Star'' and ''Fork'' buttons.

## Hosting

As with my other projects such as [YouTube Display](youtube-display) and this blog itself, the site is hosted using [GitHub Pages](https://pages.github.com/) and run through [CloudFlare](http://cloudflare.com/). GitHub Pages host the actual HTML, CSS and JS files while CloudFlare provide the TLS certificate, serve the content over CDN and take care of all the security. There are options to set [`Content-Type-Options: nosniff`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Content-Type-Options) and [HTTP Strict Transport Security](https://www.owasp.org/index.php/HTTP_Strict_Transport_Security_Cheat_Sheet) (HSTS) headers, and best of all. Best of all, using CloudFlare is completely free for non-commercial use! As it's a static site, you don't really need to worry about `X-XSS-Protection`. It'd be nice to have the option to set the `X-Frame-Options`, but hey!

This hosting stack allows you to host static sites over HTTPS using a super-fast CDN for free! Not bad.
