require "spec_helper"

describe Ebookie::Rendering::PDF do
  let(:document) { Ebookie::Document.new("My Book") }
  let(:pdf) { Ebookie::Rendering::PDF.new(document) }

  before do
    document.chapter "Introduction", "<p>This is my foo bar</p>"
    document.chapter "Image", "<img src='sample.png' alt='Image' />"
    document.image "./spec/fixtures/sample.png"

    document.configure do |config|
      config.output = './tmp/'
      config.cover = './spec/fixtures/sample-2.png'
    end
  end

  it "should return true for template?" do
    expect(pdf.template?).to be true
  end

  describe "process! method" do
    it "should create the pdf" do
      pdf.render
      expect(File.exists?('./tmp/my-book.pdf')).to be true
    end
  end

end