class CommentsController < InheritedResources::Base
  belongs_to :article
  respond_to :html, :only => [:create, :new]
  respond_to :js, :only => [:create, :new ]

end
