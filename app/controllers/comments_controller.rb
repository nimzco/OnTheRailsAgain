class CommentsController < InheritedResources::Base
  belongs_to :article
  before_filter :authenticate_author!, :only => ["new", "create", "edit"]
  respond_to :html, :only => [:create, :new , :edit]
  respond_to :js

  def create
    create! { article_path(@article) }
  end

end
