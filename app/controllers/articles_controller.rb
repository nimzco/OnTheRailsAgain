class ArticlesController < InheritedResources::Base
  before_filter :authenticate_author!, :only => ["new", "create"]
  
end
