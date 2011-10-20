# encoding: utf-8
class TagsController < InheritedResources::Base
  before_filter :authenticate_author!
end