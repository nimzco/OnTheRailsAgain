module ArticlesHelper

  
  def join_tags(article)
    article.tags(true).collect { |tag| link_to tag.name, articles_path(:tag => tag.name), :rel => 'tag', :class => 'btn btn-inverse' }.join(' ').html_safe
  end

  # Join all authors of an article with the keyword 'et'
  def join_authors(article)
    article.authors.collect{ |author| link_to author.name, articles_path(:author => author.name) }.join(' et ').html_safe
  end

end
