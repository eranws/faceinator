---
layout: default
title: Archive
---

# Archive

{% for post in site.posts %}

<div>
  {{ post.date | date: "%b %-d, %Y" }}
    »
  <span class='post-title'>
    <a href="{{ site.url }}{{ post.url }}">{{ post.title }}</a>
  </span>
</div>

{% endfor %}

