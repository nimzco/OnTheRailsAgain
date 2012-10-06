# -*- encoding : utf-8 -*-

# OnTheRailsAgain Rake Tasks list

require 'rake/clean'

ARTICLE_PATH = File.join(Rails.root, 'app', 'assets', 'articles')

DATE_DELIMITER         = '--date'
UPDATED_AT_DELIMITER   = '--updated_at'
TITLE_DELIMITER        = '--title'
INTRODUCTION_DELIMITER = '--introduction'
TAGS_DELIMITER         = '--tags'
CONTENT_DELIMITER      = '--content'
AUTHORS_DELIMITER      = '--authors'
ARTICLE_EXTENSION      = '.article'

# Use rake "generate_article[Name of the article.article]"
desc 'Regenerate a specific article'
task :generate_article, [:filename] => :environment do |t, args|
  article_values = parse_article_from_file args.filename
  if !(article = Article.where(:title => article_values[:title])).empty?
    article.first.delete
  end
  article = Article.create( :created_at   => article_values[:date],
                            :updated_at   => article_values[:date],
                            :title        => article_values[:title],
                            :introduction => article_values[:introduction],
                            :authors      => article_values[:authors],
                            :content      => haml2html(article_values[:content]),
                            :activated    => true)
  article.tags << article_values[:tags]
  article.save

end

desc 'Create new articles'
task :add_new_articles => :environment do
  Dir.open(ARTICLE_PATH).each do |article_name|
    next if File.extname(article_name) != ARTICLE_EXTENSION # Treat file only .article file

    article_values = parse_article_from_file article_name
    # Create the article only if it doesn't exist yet
    if Article.where(:title => article_values[:title]).empty?
      article = Article.create( :created_at   => article_values[:date],
                                :updated_at   => article_values[:date],
                                :title        => article_values[:title],
                                :introduction => article_values[:introduction],
                                :authors      => article_values[:authors],
                                :content      => haml2html(article_values[:content]),
                                :activated    => true)
      article.tags << article_values[:tags]
      article.save
    end
  end
end

desc 'Generate all articles'
task :generate_articles => :environment do
  # First, delete all existing articles
  Article.delete_all
  Tag.delete_all
  Dir.open(ARTICLE_PATH).each do |article_name|
    next if File.extname(article_name) != ARTICLE_EXTENSION # Treat file only .article file

    article_values = parse_article_from_file article_name

    article = Article.create( :created_at   => article_values[:date],
                              :title        => article_values[:title],
                              :introduction => article_values[:introduction],
                              :authors      => article_values[:authors],
                              :content      => haml2html(article_values[:content]),
                              :activated    => true)
    article.tags << article_values[:tags]
    article.save
  end
end

# Parse an File article to parse and create a new article
# Returns a hash containing all values of an article
def parse_article_from_file article_file_name
  article_values                = {}
  article_values[:content]      = ''
  article_values[:introduction] = ''
  article_values[:tags]         = []
  article_values[:authors]      = []
  article_values[:title]        = ''
  article_values[:date]         = nil
  article_values[:updated_at]   = nil
  next_is                       = ''

  puts "Parsing: #{article_file_name}"
  File.open(File.join(ARTICLE_PATH, article_file_name), 'r') do |article_file|
    article_file.each_line do |line|
      next if line.blank?
      ##### Checking what next line will be
      # Detect date
      if line.include?(DATE_DELIMITER)
        next_is = 'date'
      # Detect updated_at date
      elsif line.include?(UPDATED_AT_DELIMITER)
        next_is = 'updated_at'
      # Detect introduction
      elsif line.include?(INTRODUCTION_DELIMITER)
        next_is = 'introduction'
      # Detect content
      elsif line.include?(CONTENT_DELIMITER)
        next_is = 'content'
      elsif line.include?(TAGS_DELIMITER)
        next_is = 'tags'
      elsif line.include?(TITLE_DELIMITER)
        next_is = 'title'
      elsif line.include?(AUTHORS_DELIMITER)
        next_is = 'authors'
      else
        case(next_is)
          when 'date'         then article_values[:date]         = Time.zone.parse(line.strip)
          when 'updated_at'   then article_values[:updated_at]   = Time.zone.parse(line.strip)
          when 'introduction' then article_values[:introduction] << line.strip
          when 'content'      then article_values[:content]      << line
          when 'title'        then article_values[:title]        << line.strip
          when 'authors'      then
            line.strip.split(',').each do |author|
              author.strip! # Removing eventual spaces at the begining or at the end
              article_values[:authors] << Author.where(:name => author).first unless Author.where(:name => author).empty?
            end
          when 'tags'         then
            line.strip.split(',').each do |tag_name|
              tag_name.strip! # Removing eventual spaces at the begining or at the end
              # If the tag exists, add it to the list of tags
              if Tag.where(:name => tag_name).empty?
                article_values[:tags] << Tag.create(:name => tag_name)
              else
                article_values[:tags] << Tag.where(:name => tag_name).first
              end
            end
        end
      end
    end
  end
  return article_values
end

def haml2html(content)
  new_content = Haml::Engine.new(content).to_html
  new_content.gsub(/<pre class='[^>]*'>.*<\/pre>/) do |matched|
    string = matched.sub(/<pre class='[^>]*'>/, "").sub(/<\/pre>/, "")
    string = string.gsub(/&#x000A;/, "\n").gsub(/&quot;/, '"')
    # highlight(string, language)
    output = "<pre class='prettyprint linenums'>"
    # output << `node lib/tasks/highlight.js '#{CGI::escapeHTML(string)}'`
    output << CGI::escapeHTML(string)
    output << "</pre>"
    output
  end.html_safe
end

