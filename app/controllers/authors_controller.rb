# encoding: utf-8
class AuthorsController < ApplicationController

  def index  
  end
  
  def show
    if    params[:id].downcase == 'nima'
      render 'nima'
    elsif params[:id].downcase == 'nicolas'
      render 'nicolas'
    end
  end

end