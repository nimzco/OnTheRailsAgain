module ArticlesHelper

  def nested_comments(comments)
    comments.map do |comment, sub_comment|
      if sub_comment.empty?
        render(:partial => "comments/comment", :locals => {:comment => comment})
      else
        render(:partial => "comments/comment", :locals => {:comment => comment}) + content_tag(:ul, nested_comments(sub_comment))
      end
    end.join.html_safe
  end  

end
