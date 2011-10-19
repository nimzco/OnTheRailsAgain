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
 describe :summary do
    it 'should generate a correct summary 1' do
      article = Article.new(:content => """
        <h1>Article Title</h1>
          <h2>First Section</h2>
          <h2>Second Section</h2>
            <h3>First subsection</h3>
            <h3>Second subsection</h3>
          <h2>Third Section</h2>
      """)
      article.generate_summary
      expected_summary = """
      <ul>
        <li><a href='#article-title'>Article Title</a>
          <ul>
            <li><a href='#first-section'>First Section</a></li>
            <li><a href='#second-section'>Second Section</a>
              <ul>
                <li><a href='#first-subsection'>First subsection</a></li>
                <li><a href='#second-subsection'>Second subsection</a></li>
              </ul>
            </li>
            <li><a href='#third-section'>Third Section</a></li>
          </ul>
        </li>
      </ul>
      """.gsub(/\n/,'').gsub(/> +</,'><').gsub(/^ +/,'').gsub(/ +$/,'') # Gsubs used to eliminate extra spaces between HTML Tags
      article.summary.should == expected_summary
    end
    it 'should generate a correct summary 2' do
      article = Article.new(:content => """
        <h1>Article Title</h1>
          <h2>First Section</h2>
          <h2>Second Section</h2>
            <h3>First subsection</h3>
            <h3>Second subsection</h3>
      """)
      article.generate_summary
      expected_summary = """
      <ul>
        <li><a href='#article-title'>Article Title</a>
          <ul>
            <li><a href='#first-section'>First Section</a></li>
            <li><a href='#second-section'>Second Section</a>
              <ul>
                <li><a href='#first-subsection'>First subsection</a></li>
                <li><a href='#second-subsection'>Second subsection</a></li>
              </ul>
            </li>
          </ul>
        </li>
      </ul>
      """.gsub(/\n/,'').gsub(/> +</,'><').gsub(/^ +/,'').gsub(/ +$/,'') # Gsubs used to eliminate extra spaces between HTML Tags
      article.summary.should == expected_summary
    end
    it 'should generate a correct summary 3' do
      article = Article.new(:content => """
        <h1>Article Title</h1>
          <h2>First Section</h2>
          <h2>Second Section</h2>
            <h3>First subsection</h3>
            <h3>Second subsection</h3>
        <h1>Second Title</h1>
      """)
      article.generate_summary
      expected_summary = """
      <ul>
        <li><a href='#article-title'>Article Title</a>
          <ul>
            <li><a href='#first-section'>First Section</a></li>
            <li><a href='#second-section'>Second Section</a>
              <ul>
                <li><a href='#first-subsection'>First subsection</a></li>
                <li><a href='#second-subsection'>Second subsection</a></li>
              </ul>
            </li>
          </ul>
        </li>
        <li><a href='#second-title'>Second Title</a></li>
      </ul>
      """.gsub(/\n/,'').gsub(/> +</,'><').gsub(/^ +/,'').gsub(/ +$/,'') # Gsubs used to eliminate extra spaces between HTML Tags
      article.summary.should == expected_summary
    end
    it 'should generate a correct summary 4' do
      article = Article.new(:content => """
        <h1>Article Title</h1>
          <h2>First Section</h2>
          <h2>Second Section</h2>
            <h3>First subsection</h3>
            <h3>Second subsection</h3>
          <h2>Third Section</h2>
        <h1>Second Title</h1>
          <h2>First Section</h2>
            <h3>First subsection</h3>
        
      """)
      article.generate_summary
      expected_summary = """
      <ul>
        <li><a href='#article-title'>Article Title</a>
          <ul>
            <li><a href='#first-section'>First Section</a></li>
            <li><a href='#second-section'>Second Section</a>
              <ul>
                <li><a href='#first-subsection'>First subsection</a></li>
                <li><a href='#second-subsection'>Second subsection</a></li>
              </ul>
            </li>
            <li><a href='#third-section'>Third Section</a></li>
          </ul>
        </li>
        <li><a href='#second-title'>Second Title</a>
          <ul>
            <li><a href='#first-section'>First Section</a>
              <ul>
                <li><a href='#first-subsection'>First subsection</a></li>
              </ul>
            </li>
          </ul>
        </li>
      </ul>
      """.gsub(/\n/,'').gsub(/> +</,'><').gsub(/^ +/,'').gsub(/ +$/,'') # Gsubs used to eliminate extra spaces between HTML Tags
      article.summary.should == expected_summary
    end

  end
  
end