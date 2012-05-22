atom_feed :language => 'fr-FR', :id => feed_url do |feed|
  feed.title "OnTheRailsAgain"
  feed.updated @articles.first.created_at

  @articles.each do |article|
    feed.entry( article, { :id => article_url(article), 
                           :url => article_url(article),
                           :updated => article.created_at}) do |entry|
      entry.summary article.introduction
      entry.title article.title
      entry.author do |author|
        author.name join_authors_without_link(article)
      end      
      entry.content article.content, :type => 'html'
    end
  end
end