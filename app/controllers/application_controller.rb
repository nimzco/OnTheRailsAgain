# encoding: utf-8
class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery
  before_filter :check_url, :init_header

  unless Rails.configuration.consider_all_requests_local
    rescue_from Exception,                            with: :render_error
    rescue_from ActiveRecord::RecordNotFound,         with: :render_not_found
    rescue_from ActionController::RoutingError,       with: :render_not_found
    rescue_from ActionController::UnknownController,  with: :render_not_found
    rescue_from ActionController::UnknownAction,      with: :render_not_found
  end

  def render_not_found
    render template: 'errors/not_found', status: :not_found
  end

  def render_error
    render template: 'errors/internal_server_error', status: :not_found
  end

  private

  def init_header
    @search = current_author ? Article.where(params[:search]) : Article.active.where(params[:search])
    @tags = Tag.order('name ASC')
  end

  def check_url
    if /^www/.match(request.host) or '81.65.7.225'.match(request.host)
      redirect_to request.protocol + 'ontherailsagain.com' + request.fullpath, status: 301
    end
  end

end
