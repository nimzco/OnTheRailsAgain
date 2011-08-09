class CommentsController < InheritedResources::Base
  belongs_to :article
  respond_to :html, :only => [:create, :new , :edit]
  respond_to :js

end
