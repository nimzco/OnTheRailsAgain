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

  def highlight(code, language = :ruby)
    Albino.new(code, language).to_s
  end
  
  def haml2html(content)
    @new_content = Haml::Engine.new(content).to_html
    @new_content.gsub(/<pre.*<\/pre>/) do |match|
      @language = match.match(/<pre class='(.*)'>.*pre>/)[1]
      @string   = match.sub(/<pre.*'>/, "").sub(/<\/pre>/, "")
      @string   = @string.gsub(/&#x000A;/, "\n").gsub(/&quot;/, '"')
      highlight(@string, @language)
    end.html_safe
  end

end
