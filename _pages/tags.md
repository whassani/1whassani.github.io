---
permalink: /tags/
layout:    default
title:     Qui est Arionys ?
---

<div class="tags-expo">
  <div class="tags-expo-list">
    {% for tag in site.tags %}
    <a href="#{{ tag[0] | slugify }}" class="post-tag">{{ tag[0] }}</a>
    {% endfor %}
  </div>
  <hr/>
  <div class="tags-expo-section">
    {% for tag in site.tags %}
    <h2 id="{{ tag[0] | slugify }}">{{ tag[0] }}</h2>
    <ul class="tags-expo-posts">
      {% for post in tag[1] %}
        <a class="post-title" href="{{ site.baseurl }}{{ post.url }}">
      <li>
        {{ post.title }}
      <small class="post-date">{{ post.date | date_to_string }}</small>
      </li>
      </a>
      {% endfor %}
    </ul>
    {% endfor %}
  </div>
</div>


{% capture site_tags %}{% for tag in site.tags %}{{ tag | first }}{% unless forloop.last %},{% endunless %}{% endfor %}{% endcapture %}
{% assign tag_words = site_tags | split:',' | sort %}


<div class="col-sm-3 col-xs-6">
    <ul class="nav nav-tabs-vertical cat-tag-menu">
    {% for item in (0..site.tags.size) %}{% unless forloop.last %}
      {% capture this_word %}{{ tag_words[item] | strip_newlines }}{% endcapture %}
      <li>
          <a href="#{{ this_word | replace:' ','-' }}-ref">
            {{ this_word }}<span class="badge pull-right">{{ site.tags[this_word].size }}</span>
         </a>
      </li>
   {% endunless %}{% endfor %}
   </ul>
</div>
<!-- Tab panes -->
<div class="tab-content col-sm-9 col-xs-6">
  {% for item in (0..site.tags.size) %}{% unless forloop.last %}
    {% capture this_word %}{{ tag_words[item] | strip_newlines }}{% endcapture %}
    <div class="tab-pane" id="{{ this_word | replace:' ','-' }}-ref">
      <h2 style="margin-top: 0px">Posts tagged  with {{ this_word }}</h2>
      <ul class="list-unstyled">
        {% for post in site.tags[this_word] %}{% if post.title != null %}
          <li style="line-height: 35px;"><a href="{{ site.BASE_PATH }}{{post.url}}">{{post.title}}</a> <span class="text-muted">- {{ post.date | date: "%B %d, %Y" }}</span></li>
        {% endif %}{% endfor %}
      </ul>
    </div>
  {% endunless %}{% endfor %}
</div>

<div class="clearfix"></div>
