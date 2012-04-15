# encoding: utf-8
class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery
  before_filter :check_url, :init_header
  
  def init_header
    @search = current_author ? Article.search(params[:search]) : Article.where(:articles => {:activated => true}).search(params[:search])
    @tags = Tag.find(:all, :order => :name)
  end
  
  def check_url
    redirect_to request.protocol + request.host_with_port[4..-1] + request.fullpath, :status => 301 if /^www/.match(request.host)
  end
  
end
