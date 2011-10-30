# encoding: utf-8

class ArticlesController < InheritedResources::Base
  before_filter :authenticate_author!, :only => ["new", "create", "edit"]
  before_filter :set_page_name
  respond_to :rss
  
  def set_page_name
    @page = :article
  end
  
  def index  
    @search = current_author ? Article.search(params[:search]) : Article.where(:articles => {:activate => true}).search(params[:search])
    @search_text = ''
    if params[:tag]
      @articles = Article.page(params[:page]).find(:all, :order => 'Articles.created_at DESC', :include => :tags, :conditions => ["tags.name = ?", params[:tag]])
      @search_text = "Article#{@articles.size > 1 ? 's' : ''} correspondant au tag : " + params[:tag]
    elsif params[:author]
      @articles = Article.page(params[:page]).find(:all, :order => 'Articles.created_at DESC', :include => :authors, :conditions => ["authors.name = ?", params[:author]])
      @search_text = "Article#{@articles.size > 1 ? 's' : ''} ayant pour auteur : " + params[:author]      
    else
      @articles = @search.page(params[:page]).order('created_at DESC')
      @search_text = "Article#{@articles.size > 1 ? 's' : ''} correspondant à la recherche : «#{params[:search]["title_or_content_contains"]}»" if params[:search]
    end
    @tags = Tag.find(:all, :order => :name)
    index!
  end

  def new
    @article = Article.new
    @article.authors << current_author
    new!
  end
  
  def show
    # Redirect user on correct URL if params[:id] is an integer
    if params[:id].to_i > 0
      @article = Article.find params[:id]
      redirect_to :action => :show, :id => @article.link
    else
      @article = Article.where("link = ?", params[:id]).first
      show!
    end
  end

  def edit
    @article = Article.where("link = ?",  params[:id]).first
    edit!
  end
  
  def create
    @article = Article.new(params[:article])
    begin
      @article.content = if Rails.env != 'production' then haml2html(params[:article][:content]) else params[:article][:content] end
      @article.generate_summary
      @article.generate_anchor_links
      @article.title = params[:article][:title]
      @article.generate_link
      create!
    rescue Haml::SyntaxError => e
      puts e
      respond_to do |format|
        format.html { render "new" }
      end
    end
  end
  
  def update
    @article = Article.find(params[:id])
    @article.content = if Rails.env != 'production' then haml2html(params[:article][:content]) else params[:article][:content] end
    @article.generate_summary
    @article.generate_anchor_links
    @article.title = params[:article][:title]
    @article.generate_link
    if @article.save
      respond_to do |format|
        format.html { redirect_to @article }
      end
    else
      respond_to do |format|
        format.html { render action "edit", :notice => "Un problème est survenue à l'enregistrement."}
      end
    end
  end
  
  def activate
    @article = Article.find params[:id]
    @article.activate_article
    @article.save
    redirect_to articles_path
  end
  
  def desactivate
    @article = Article.find params[:id]
    @article.desactivate
    @article.save
    redirect_to articles_path
  end
  
  def activate_all
    @articles = Article.all
    @articles.each do |article|
      article.activate_article
      article.save  
    end  
    redirect_to articles_path
  end
  
  def desactivate_all
    @articles = Article.all
    @articles.each do |article|
      article.desactivate
      article.save  
    end  
    redirect_to articles_path
  end
  
  private

  def highlight(code, language = :ruby)
    Albino.new(code, language).to_s
  end
  
  def haml2html(content)
    @new_content = Haml::Engine.new(content).to_html

    @new_content.gsub(/<pre.*<\/pre>/) do |matched|
      @language = matched.match(/<pre class='([aA-zZ]*)'>.*pre>/)[1]
      @string   = matched.sub(/<pre class='([aA-zZ]*)'>/, "").sub(/<\/pre>/, "")
      @string   = @string.gsub(/&#x000A;/, "\n").gsub(/&quot;/, '"')
      highlight(@string, @language)
    end.html_safe
  end
end