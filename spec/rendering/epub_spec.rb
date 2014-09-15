require "spec_helper"

describe Ebookie::Rendering::Epub do
  let(:document) { Ebookie::Document.new("My Book") }
  let(:epub) { Ebookie::Rendering::Epub.new(document) }

  it "should have a template" do
    expect(epub.templatedir).to be_a Pathname
  end

  it "should return true for template?" do
    expect(epub.template?).to be true
  end

  it "should have #format equal to epub" do
    expect(epub.format).to eq 'epub'
  end

  describe "process! method" do
    before :each do
      document.chapter "Introduction", "This is my foo bar"
      document.configure do |config|
        config.output = './tmp/'
      end
    end

    it "should write chapters to files" do
      expect(Epzip).to receive(:zip).and_return(true)
      expect(EpubValidator).to receive(:check).and_return OpenStruct.new({:valid? => true})

      epub.render
      expect(File.exists?('./tmp/my-book/epub/OEBPS/introduction.html')).to be true
    end

    it "should process renderer" do
      expect_any_instance_of(Ebookie::Rendering::Epub).to receive(:process!)
      epub.render
    end

    it "should create the epub" do
      epub.render
      expect(File.exists?('./tmp/my-book.epub')).to be true
    end
  end
end