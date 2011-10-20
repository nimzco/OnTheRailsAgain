# encoding: utf-8
class SitemapController < ApplicationController
  def index
    respond_to do |format|
      format.xml
    end
  end
end
