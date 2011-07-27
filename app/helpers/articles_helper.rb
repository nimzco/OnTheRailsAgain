module ArticlesHelper

  def nested_comments(comments)
    comments.map do |comment, sub_comment|
      render(:partial => "comments/comment", :locals => {:comment => comment}) + content_tag(:ul, nested_comments(sub_comment))
    end.join.html_safe
  end  

  def highlight(code)
    Albino.new(code, :ruby).to_s.html_safe
  end

end
