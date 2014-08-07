---
layout: page
title: Archive
---

## Blog Posts

{% for category in site.categories %}
  ### {{ category }}
  {% for posts in category %}
    {% for post in posts %}
      * <span style="color:#9a9a9a">{{ post.date | date_to_string }}</span> &raquo; [ {{ post.title }} ]({{ post.url }})
    {% endfor %}
  {% endfor %}
{% endfor %}
