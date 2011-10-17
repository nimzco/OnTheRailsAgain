class ArticlesController < InheritedResources::Base
  before_filter :authenticate_author!, :only => ["new", "create", "edit"]
  before_filter :set_page_name
  respond_to :rss
  
  def set_page_name
    @page = :article
  end
  
  def index
    @search = Article.search(params[:search], :order => 'created_at DESC')
    @search_text = ""
    if params[:tag]
      @articles = Article.find(:all, :order => 'Articles.created_at DESC', :include => :tags, :conditions => ["tags.name = ?", params[:tag]]).paginate(:page => params[:page], :per_page => 5)
      @search_text = "Article#{@articles.size > 1 ? 's' : ''} correspondant au tag : " + params[:tag]
    elsif params[:author]
      @articles = Article.find(:all, :order => 'Articles.created_at DESC', :include => :authors, :conditions => ["authors.name = ?", params[:author]]).paginate(:page => params[:page], :per_page => 5)
      @search_text = "Article#{@articles.size > 1 ? 's' : ''} ayant pour auteur : " + params[:author]      
    else
      @articles = @search.all(:order => 'created_at DESC').paginate(:page => params[:page], :per_page => 5)
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
    @article = Article.where("link = ?", params[:id]).first
    show!
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
      @article.link = escape_accent params[:article][:title]
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
    @article.link = escape_accent params[:article][:title]
    params[:article][:content] = @article.content
    update!
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

  private
  def escape_accent(string)
    string.gsub(/ /, '_').gsub(/[éèêë]/,'e').gsub(/[âà]/,'a').gsub(/[îï]/,'i').gsub(/[ûüù]/,'u')
  end

end