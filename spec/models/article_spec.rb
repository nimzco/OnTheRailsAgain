require 'spec_helper'

describe :Article do
  

  describe :article_link do
    before(:each) do
      @article = Article.new(:title => "Generic Title")
    end

    it 'should be downcase' do
      @article.generate_link
      @article.link.should be_downcase
      
    end
    
    it 'should generate a correct URL' do
      @article.title = "A ComPlicatéd:UrL?"
      @article.generate_link
      @article.link.should == 'a-complicated-url'    
    end
  end
end