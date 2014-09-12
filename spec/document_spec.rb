require "spec_helper"

describe Ebookie::Document do
  let(:document) { Ebookie::Document.new("My Title") }

  it "should have a chapters array" do
    expect(document.chapters).to be_a Array
  end

  it "should have a title" do
    expect(document.title).to eq "My Title"
  end

  describe "#configure method" do
    it "should yield block for setting options" do
      document.configure do |config|
        config.title = 'bar'
        config.output = 'foo'
      end

      expect(document.config.title).to eq 'bar'
      expect(document.config.output).to eq 'foo'
    end
  end

  describe "#chapter method" do
    it "should add a Chapter object" do
      document.chapter 'foo', 'bar'
      expect(document.chapters.first).to be_a Ebookie::Document::Chapter
    end
  end
end