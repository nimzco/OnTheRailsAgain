class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
 
  def record_not_found
    render :file => "#{Rails.root}/public/404.html", :status => :not_found
  end

end
