class ArticlesController < InheritedResources::Base
  before_filter :authenticate_author!, :only => ["new", "create", "edit"]
  before_filter :set_page_name
  
  def set_page_name
    @page = :article
  end
  
  def index
    if params[:tag]
      @articles = Article.find(:all, :include => :tags, :conditions => ["tags.name = ?", params[:tag]]).paginate(:page => params[:page], :per_page => 5)
    else
      @articles = Article.all.paginate(:page => params[:page], :per_page => 5)
    end
    @tags = Tag.all
    index!
  end

  def new
    @article = Article.new
    @article.authors << current_author
    new!
  end
  
  def show
    @comment = Comment.new
    @article = Article.find_by_title(params[:id].gsub(/_/," "))
    show!
  end

  def edit
    @article = Article.find_by_title(params[:id].gsub(/_/," "))
    edit!
  end
  
  def create
    @article = Article.create(params[:article])
    @article.content = haml2html(params[:article][:content])
    @article.generate_summary
    create!
  end
  
  def update
    @article = Article.find(params[:id])
    @article.content = haml2html(params[:article][:content])
    params[:article][:content] = @article.content
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