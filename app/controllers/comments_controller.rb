class CommentsController < InheritedResources::Base
  belongs_to :article
  respond_to :js

  before_filter :authenticate_author!, :only => ["new", "create", "edit"]
  respond_to :html, :only => [:create, :new , :edit]
  
  def create
    create! { article_path(@article) }
  end

end
