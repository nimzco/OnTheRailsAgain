# -*- encoding : utf-8 -*-

# OnTheRailsAgain Rake Tasks list

require 'rake/clean'
ARTICLE_PATH = File.join(Rails.root, 'app', 'assets', 'articles')

DATE_DELIMITER         = '--date'
# TITLE_DELIMITER      = '--title' ?
INTRODUCTION_DELIMITER = '--introduction'
TAGS_DELIMITER         = '--tags'
CONTENT_DELIMITER      = '--content'
ARTICLE_EXTENSION      = '.article'

namespace :otra do

  desc 'Generate all articles'
  task :generate_article => :environment do 
    Dir.open(ARTICLE_PATH).each do |article|
      next if File.extname(article) != ARTICLE_EXTENSION # Treat file only .article file
      
      puts "Adding: #{article}"
      File.open(File.join(ARTICLE_PATH, article), 'r') do |article_file|
        introduction = ''
        content      = ''
        date         = nil
        next_is      = ''
        tags         = []
        article_file.each_line do |line|
          next if line.blank?
          ##### Checking what next line will be
          # Detect date
          if line.include?(DATE_DELIMITER)
            next_is = 'date'
          # Detect introduction
          elsif line.include?(INTRODUCTION_DELIMITER)
            next_is = 'introduction'
          # Detect content
          elsif line.include?(CONTENT_DELIMITER)
            next_is = 'content'
          elsif line.include?(TAGS_DELIMITER)
            next_is = 'tags'
          else
            case(next_is)
              when 'date'         then date = Date.parse(line.lstrip)
              when 'introduction' then introduction << line
              when 'content'      then content << line
              when 'tags'         then 
                line.split(',').each do|tag_name|
                  tag_name.strip!
                  # If the tag exists, add it to the list of tags
                  if tag = Tag.where(:name => tag_name).first
                    tags << tag
                  else
                    tags << Tag.create(:name => tag_name)
                  end
                end
            end
          end
        end

        article = Article.create( :created_at => date,
                        :title        => article.chomp(ARTICLE_EXTENSION),
                        :introduction => introduction,
                        :content      => haml2html(content),
                        :activated    => true)
        article.tags << tags

      end
    end
  end

#   desc 'Update all articles'
#   task :update_article => :environment do
#   end
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

