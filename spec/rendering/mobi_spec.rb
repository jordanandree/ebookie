require "spec_helper"

describe Ebookie::Rendering::Mobi do
  let(:document) { Ebookie::Document.new("My Book") }
  let(:mobi) { Ebookie::Rendering::Mobi.new(document) }

  it "should not have set for paths" do
    expect(mobi.respond_to?(:paths)).to be false
  end

  it "should return false for template?" do
    expect(mobi.template?).to be false
  end

  it "should have #format equal to mobi" do
    expect(mobi.format).to eq 'mobi'
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