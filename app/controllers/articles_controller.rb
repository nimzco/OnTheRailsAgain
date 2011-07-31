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
end