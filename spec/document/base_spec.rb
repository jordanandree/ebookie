# frozen_string_literal: true
require "spec_helper"

describe Ebookie::Document::Base do
  let(:document) { Ebookie::Document::Base.new("My Title") }

  before do
    document.config.destination = "./tmp"
  end

  it "should have a chapters array" do
    expect(document.chapters).to be_a Array
  end

  it "should have a title" do
    expect(document.title).to eq "My Title"
  end

  describe "#configure method" do
    it "should yield block for setting options" do
      document.configure do |config|
        config.title = "bar"
        config.destination = "foo"
      end

      expect(document.config.title).to eq "bar"
      expect(document.config.destination).to eq "foo"
    end
  end

  describe "#chapter method" do
    it "should add a Chapter object" do
      document.chapter "foo", "bar"
      expect(document.chapters.first).to be_a Ebookie::Document::Chapter
    end
  end

  describe "#image method" do
    it "should add a Image object" do
      document.image "sample.png"
      expect(document.images.first).to be_a Ebookie::Document::Image
    end
  end

  describe "#render_pdf method" do
    it "should call the renderer" do
      expect_any_instance_of(Ebookie::Rendering::Pdf).to receive(:render)
      document.render_pdf
    end
  end

  describe "#render_epub method" do
    it "should call the renderer" do
      expect_any_instance_of(Ebookie::Rendering::Epub).to receive(:render)
      document.render_epub
    end
  end

  describe "#render_mobi method" do
    it "should call the renderer" do
      expect_any_instance_of(Ebookie::Rendering::Mobi).to receive(:render)
      document.render_mobi
    end
  end
end
