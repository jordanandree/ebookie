require "spec_helper"

describe Ebookie::Rendering::Mobi do
  let(:document) { Ebookie::Document.new("My Book") }
  let(:mobi) { Ebookie::Rendering::Mobi.new(document) }

  before :each do
    document.config.cover = './spec/fixtures/sample.png'
  end

  describe "configuration" do
    it "should not have set option for :paths" do
      expect(mobi.respond_to?(:paths)).to be false
    end

    it "should not have set option for :files" do
      expect(mobi.respond_to?(:files)).to be false
    end

    it "should have a template" do
      expect(mobi.templatedir).to be_a Pathname
    end

    it "should return false for template?" do
      expect(mobi.template?).to be false
    end

    it "should have #format equal to mobi" do
      expect(mobi.format).to eq 'mobi'
    end
  end

  describe "process! method" do
    before :each do
      document.chapter "Introduction", "This is my foo bar"
      document.configure do |config|
        config.output = './tmp/'
      end
    end

    it "should convert epub to mobi" do
      mobi.render
      expect(File.exists?('./tmp/my-book.mobi')).to be true
    end
  end
end