# encoding: utf-8
#
# Tag Page generator for Jekyll
# https://github.com/morganp/Octopress_tags
#
# Included Filter :
# - tag_links
#
# Available _config.yml settings :
# - tag_dir : subdirectory to put tags in default is 'tag'
module Jekyll
  class TagGenerator < Generator
    safe true
    priority :low
    # Jekyll hook 
    # - the generate method is called by jekyll, and generates all of the tag pages.
    def generate(site)
      if site.layouts.key? 'tag_index'
        dir = site.config['tag_dir'] || 'tag'
        ## Create Top level tag list /tag/index.html
        write_all_tags_index(site, dir, site.tags.keys )
        
        ## Create /tag/{{tag}}/index.html
        site.tags.keys.each do |tag|
          write_tag_index(site, File.join(dir, tag), tag)
        end
      end
    end
  
    def write_all_tags_index(site, dir, tags)
      index = TagsIndex.new(site, site.source, dir, tags)
      index.render(site.layouts, site.site_payload)
      index.write(site.dest)
      site.pages << index
    end
    
    def write_tag_index(site, dir, tag)
      index = TagIndex.new(site, site.source, dir, tag)
      index.render(site.layouts, site.site_payload)
      index.write(site.dest)
      site.pages << index
    end

  end


  class TagsIndex < Page
    def initialize(site, base, dir, tags)
      @site = site
      @base = base
      @dir  = dir
      @name = 'index.html'
      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'tags_index.html')
      self.data['tags']  = tags
      self.data['title'] = "Tags"
    end
  end
  
  
  class TagIndex < Page
    def initialize(site, base, dir, tag)
      @site = site
      @base = base
      @dir  = dir
      @name = 'index.html'
      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'tag_index.html')
      self.data['tag'] = tag
      tag_title_prefix = site.config['tag_title_prefix'] || 'Tag: '
      tag_title_suffix = site.config['tag_title_suffix'] || ''
      self.data['title'] = "#{tag_title_prefix}#{tag}#{tag_title_suffix}"
    end
  end

  # Adds some extra filters used during the category creation process.
  module Filters

    # Outputs a list of tags as comma-separated <a> links. This is used
    # to output the tag list for each post.
    #
    #  +tags+ is the list of tags to format.
    #
    # Returns string
    #

    def tag_links(tags)
      tags = tags.sort!.map { |c| tag_link c }

      case tags.length
      when 0
        ""
      when 1
        tags[0].to_s
      else
        "#{tags[0...-1].join(', ')}, #{tags[-1]}"
      end
    end

    # Outputs a single tag as an <a> link.
    #
    #  +tag+ is a tag string to format as an <a> link
    #
    # Returns string
    #
    def tag_link(tag)
      dir = @context.registers[:site].config['tag_dir'] || 'tag'
      "<a class='tag' href='/#{dir}/#{tag.to_url}/'>#{tag}</a>"
    end

  end

  
end

