require 'spec_helper'

describe Article do
  
  describe :validateion do
    let(:article) {Article.create()}
    it {article.should have(1).errors_on :title}
    it {article.should have(1).errors_on :content}
    it {article.should have(1).errors_on :introduction}
    it {article.should have(1).errors_on :link}
  end
  
  it 'should not create if an article with the same title exists' do
    article1 = Article.create(:title => 'title', :content => 'content', :introduction => 'introduction', :link => 'title')
    article2 = Article.new(:title => 'title', :content => 'content', :introduction => 'introduction', :link => 'title')
    lambda {article2.save!}.should raise_error ActiveRecord::RecordInvalid
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
  describe :activate_desactivate do
    before do
      @article = Article.new(:title => "Generic Title")
    end
    
    it 'should be desactivate just after creation' do
      @article.activate.should be_false
    end
    it 'should be activate after using activate_article' do
      @article.activate_article
      @article.activate.should be_true
    end
    it 'should be desactivate after using desactivate' do
      @article.activate_article
      @article.activate.should be_true
      @article.desactivate
      @article.activate.should be_false
    end
  end
end