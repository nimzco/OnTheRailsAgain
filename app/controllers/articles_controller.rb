class ArticlesController < InheritedResources::Base
  before_filter :authenticate_author!, :only => ["new", "create", "edit"]
  
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