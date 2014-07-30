---
layout: page
title: Archive
---

## Blog Posts

{% for post in site.posts %}
  * <span style="color:#9a9a9a">{{ post.date | date_to_string }}</span> &raquo; [ {{ post.title }} ]({{ post.url }})
{% endfor %}
