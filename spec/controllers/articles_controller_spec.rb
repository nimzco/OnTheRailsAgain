require 'spec_helper'

describe ArticlesController do
  before do
    #user = Factory.create(:author)
  end
  
  describe :index do
    it 'should display all articles activated' do
      articles = []
      articles << Article.create(:title => "test 1", :content => "test 1", :summary => "test 1", :introduction => "test 1", :link => "test 1", :activate => true)
      articles << Article.create(:title => "test 2", :content => "test 2", :summary => "test 2", :introduction => "test 2", :link => "test 2", :activate => true)
      articles << Article.create(:title => "test 3", :content => "test 3", :summary => "test 3", :introduction => "test 3", :link => "test 3", :activate => true)
      Article.create(:title => "test 4", :content => "test 4", :summary => "test 4", :introduction => "test 4", :link => "test 4", :activate => false)
      
      get :index
      assigns(:articles).should == articles
    end
  end
  
  describe :new do
    it 'should not render new view but login form' do
      @author = Author.create(:name => "Test User", :email => "user@example.com", :password => "password", :password_confirmation => "password")
      sign_in @author
      get :new
      response.should render_template("devise/sessions/new")
    end
  end
  
end