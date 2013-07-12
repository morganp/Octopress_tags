Octopress with TAGS
==

Based very much on [tags in jekyll by Charlie Park](http://charliepark.org/tags-in-jekyll/). 

For posts which include tags ie have this in the header :

    tags: 
    - Dessert
    - Cake

Octopress (Jekyll) will now generate a /tags/index.html and /tags/{{tag}}/index.html.

Three files need to be added to your site:

    ├── plugins
    │   └── tag_gen.rb
    └── source
        └── _layouts
            ├── tag_index.html
            └── tags_index.html

