# encoding: utf-8
class AuthorsController < ApplicationController

  def index  
  end
  
  def show
    if    params[:id].downcase == 'nima'
      render 'nima'
    elsif params[:id].downcase == 'nico'
      render 'nico'
    end
  end

end