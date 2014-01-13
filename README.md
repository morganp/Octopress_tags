Octopress with TAGS
==

Based very much on [tags in jekyll by Charlie Park](http://charliepark.org/tags-in-jekyll/). 

For posts which include tags ie have this in the header :

    tags: 
    - Dessert
    - Cake

Octopress (Jekyll) will now generate a /tags/index.html and /tags/{{tag}}/index.html.

Four files need to be added to your site (source/_includes/tags.html is optional):

    ├── plugins
    │   └── tag_gen.rb
    └── source
        ├── _includes
        │   └── post
        │       └── tags.html
        └── _layouts
            ├── tag_index.html
            └── tags_index.html

The include `source/_includes/tags.html` allows you to use `{% include post/tags.html %}` in your _layouts. An example :
_layouts/post.html

    ---
    layout: default
    single: true
    ---

    <div>
    <article class="hentry" role="article">
      {% include article.html %}
      <footer>
        <p class="meta">
          {% include post/author.html %}
          {% include post/date.html %}{% if updated %}{{ updated }}{% else %}{{ time }}{% endif %}
          {% include post/categories.html %}
          {% include post/tags.html %}
        </p>
        {% unless page.sharing == false %}
          {% include post/sharing.html %}
        {% endunless %}
    ...

**Becomes**

    ---
    layout: default
    single: true
    ---

    <div>
    <article class="hentry" role="article">
      {% include article.html %}
      <footer>
        <p class="meta">
          {% include post/author.html %}
          {% include post/date.html %}{% if updated %}{{ updated }}{% else %}{{ time }}{% endif %}
          {% include post/categories.html %}
          {% include post/tags.html %}
        </p>
        {% unless page.sharing == false %}
          {% include post/sharing.html %}
        {% endunless %}
     ...

