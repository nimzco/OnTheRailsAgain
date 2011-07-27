class CommentsController < InheritedResources::Base
  belongs_to :article
  respond_to :js
  
  def create
    create! { article_path(@article) }
  end

end
