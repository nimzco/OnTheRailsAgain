class TagsController < InheritedResources::Base
  before_filter :authenticate_author!
end