class Article < ActiveRecord::Base
  include ArticlesHelper
  has_and_belongs_to_many :authors
  has_and_belongs_to_many :tags

  validates :authors, :associated => true
  validates :tags   , :associated => true

  # The link is the title without spaces (blank) neither accents. It is used for URLs.
  # It has to be unique
  validates :title, :link, :uniqueness => true
  validates :title, :introduction, :content, :link, :presence => true
  
  # Generate a summary in a nested list composed of all headers of the article
  # The method is REALLY ugly because of some problem in the gsub...
  # Don't even try to understand it.
  def generate_summary
    summary_string = '<ul>'
    first = true
    oldH = 1
    self.content.gsub(/<h[0-9][^>]*>[^<]*<\/h[0-9]>/m) do |match|
      h     = match[2].chr
      title = match.sub(/<h[0-9][^>]*>/m, '').sub(/<\/h[0-9]>/m, '')
      link  = escape_accent title #.gsub(/ /, '_').gsub(/[éèêë]/,'e').gsub(/[âà]/,'a').gsub(/[îï]/,'i').gsub(/[ûüù]/,'u').gsub(/\./,'')
      if !first and (h.to_i - oldH) == 1
        summary_string += '</li><li><ul><li>'
      elsif !first and (h.to_i - oldH) == 0
        summary_string += '</li><li>'
      elsif !first and (h.to_i - oldH) == -1
        summary_string += '</li></ul><li>'
      elsif !first and (h.to_i - oldH) == -2
        summary_string += '</li></ul></ul><li>'
      elsif !first and (h.to_i - oldH) == -3
        summary_string += '</li></ul></ul></ul><li>'
      else
        summary_string += '<li>'
      end
      summary_string += "<a href='##{link}'>#{title}</a>"

      oldH = h.to_i
      first = false
    end
    summary_string += "</ul>"
    self.summary = summary_string
  end

  # Add an id to all the headers
  def generate_anchor_links
    self.content = self.content.gsub(/<h[0-9]>[^<]*<\/h[0-9]>/m) do |match|
      h     = match[2].chr
      title = match.sub(/<h[0-9]>/m, "").sub(/<\/h[0-9]>/m, "")
      link  = title.gsub(/ /, '_').gsub(/[éèêë]/,'e').gsub(/[âà]/,'a').gsub(/[îï]/,'i').gsub(/[ûüù]/,'u').gsub(/\./,'')
      "<h#{h} id='#{link}'>#{title}</h#{h}>"
    end    
  end
end
