class ArticlesController < InheritedResources::Base
  before_filter :authenticate_author!, :only => ["new", "create", "edit"]
  before_filter :set_page_name
  
  def set_page_name
    @page = :article
  end
  
  def new
    @article = Article.new
    @article.authors << current_author
    new!
  end
  
  def show
    @comment = Comment.new
    show!
  end
  
  def create
    @article = Article.create(params[:article])
    @article.content = haml2html(params[:article][:content])
    @article.generate_summary
    create!
  end
  
  def update
    @article = Article.find(params[:id])
    params[:article][:content] = haml2html(params[:article][:content])
    @article.generate_summary
    update!
  end

  private

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