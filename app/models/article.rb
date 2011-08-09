class Article < ActiveRecord::Base

  has_and_belongs_to_many :authors
  has_and_belongs_to_many :tags

  has_many                :comments

  validates_associated    :authors
  validates_associated    :tags

  validates_uniqueness_of :title
  validates_presence_of   :title, :introduction, :content

  
  def generate_summary
    self.summary = "<ul>"
    first = true
    oldH = 1
    self.content.gsub(/<h[0-9][^>]*>[^<]*<\/h[0-9]>/m) do |match|
      h     = match[2].chr
      title = match.sub(/<h[0-9][^>]*>/m, "").sub(/<\/h[0-9]>/m, "")
      link  = title.gsub(/ /, '_').gsub(/[éèêë]/,'e').gsub(/[âà]/,'a').gsub(/[îï]/,'i').gsub(/[ûüù]/,'u').gsub(/\./,'')
      if !first and (h.to_i - oldH) == 1
        self.summary += "<ul>"
      elsif !first and (h.to_i - oldH) == -1
        self.summary += "</ul>"
      elsif !first and (h.to_i - oldH) == -2
        self.summary += "</ul></ul>"
      elsif !first and (h.to_i - oldH) == -3
        self.summary += "</ul></ul></ul>"
      end
      self.summary += "<li><a href='##{link}'>#{title}</a></li>"
      oldH = h.to_i
      first = false
    end
    self.summary += "</ul>"
  end

  def generate_anchor_links

    self.content = self.content.gsub(/<h[0-9]>[^<]*<\/h[0-9]>/m) do |match|
      h     = match[2].chr
      title = match.sub(/<h[0-9]>/m, "").sub(/<\/h[0-9]>/m, "")
      link  = title.gsub(/ /, '_').gsub(/[éèêë]/,'e').gsub(/[âà]/,'a').gsub(/[îï]/,'i').gsub(/[ûüù]/,'u').gsub(/\./,'')
      "<h#{h} id='#{link}'>#{title}</h#{h}>"
    end
    
  end
end
