class ProfilesController < ApplicationController

  def show
    @author = Author.find_by_name(params[:name])
  end
  
end