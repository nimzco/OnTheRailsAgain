module ArticlesHelper

  def nested_comments(comments)
    comments.map do |comment, sub_comment|
      if sub_comment.empty?
        render(:partial => "comments/comment", :locals => {:comment => comment})
      else
        render(:partial => "comments/comment", :locals => {:comment => comment}) + nested_comments(sub_comment)
      end
    end.join.html_safe
  end  

  def join_tags(article)
    article.tags.map { |tag| link_to tag.name, articles_path(:tag => tag.name) }.join(" - ").html_safe
  end

  def join_authors(article)
    if article.authors(true)[1]
      "#{link_to article.authors[0].name, articles_path(:author => article.authors[0].name)} et #{link_to article.authors[1].name, articles_path(:author => article.authors[1].name)}"
    else
      "#{link_to article.authors[0].name, articles_path(:author => article.authors[0].name)}"
    end.html_safe
  end
end
