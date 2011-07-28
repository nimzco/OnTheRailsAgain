module ArticlesHelper

  def nested_comments(comments)
    comments.map do |comment, sub_comment|
      render(:partial => "comments/comment", :locals => {:comment => comment}) + content_tag(:ul, nested_comments(sub_comment))
    end.join.html_safe
  end  

  def highlight(code)
    Albino.new(code, :ruby).to_s
  end
  
  # To refactor...
  def haml2html(content)
    begin
      @new_content = Haml::Engine.new(content).to_html
    rescue Haml::SyntaxError
      @new_content = "Problème d'encodage..."
    end
    @new_content.gsub(/<pre.*<\/pre>/) do |match|
      @string = match.sub(/<pre.*'>/, "").sub(/<\/pre>/, "")
      @string = @string.gsub(/&#x000A;/, "\n").gsub(/&quot;/, '"')
      highlight(@string)
    end.html_safe
  end

end
