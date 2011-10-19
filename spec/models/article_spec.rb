require 'spec_helper'

describe Article do
  
  describe :validateion do
    article = Article.create()
    article.should have(1).errors_on :title
    article.should have(1).errors_on :content 
    article.should have(1).errors_on :introduction
    article.should have(1).errors_on :link
  end

  describe :article_link do
    before do
      @article = Article.new(:title => "Generic Title")
    end

    it 'should be downcase' do
      @article.generate_link
      @article.link.each_char do |char|
        char.downcase.should == char
      end
      
    end
    
    it 'should generate a correct URL' do
      @article.title = "A ComPlicatéd:UrL?"
      @article.generate_link
      @article.link.should == 'a-complicated-url'    

      @article.title = "-A ComPlicatéd:UrL?-a'é"
      @article.generate_link
      @article.link.should == 'a-complicated-url-a-e'    
    end
  end
end