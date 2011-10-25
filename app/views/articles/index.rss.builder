xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "OnTheRailsAgain"
    xml.description "Blog destiné à une communauté francophone voulant se lancer dans l'apprentissage de Ruby On Rails."
    xml.link articles_url(:rss)
    
    for article in @articles
      if article.activate
        xml.item do
          xml.title article.title
          xml.description article.content
          xml.pubDate article.created_at.to_s(:rfc822)
          xml.link article_url(:controller => "articles", :action => "show", :id => article.link)
          xml.guid article_url(article)
        end
      end
    end
  end
end