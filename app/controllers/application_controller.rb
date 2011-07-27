class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
 
  private
 
  def record_not_found
    render "shared/error404", :status => 404
  end

end
