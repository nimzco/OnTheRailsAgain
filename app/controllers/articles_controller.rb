class ArticlesController < InheritedResources::Base
  before_filter :authenticate_author!, :only => ["new", "create"]
  
  def new
    @article = Article.new
    @article.authors << current_author
    new!
  end
    
end
