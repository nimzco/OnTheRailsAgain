class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :check_url

  def check_url
    redirect_to request.protocol + request.host_with_port + request.request_uri, :status => 301 if /^www/.match(request.host)
  end
end
