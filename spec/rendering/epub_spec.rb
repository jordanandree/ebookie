# frozen_string_literal: true
require "spec_helper"

describe Ebookie::Rendering::Epub do
  let(:document) { Ebookie::Document.new("My Book") }
  let(:epub) { Ebookie::Rendering::Epub.new(document) }

  before do
    document.chapter "Introduction", "This is my foo bar"
    document.chapter "Image", "<img src='sample.png' alt='Image' />"
    document.image "./spec/fixtures/sample.png"

    document.configure do |config|
      config.destination = "./tmp/"
      config.cover = "./spec/fixtures/sample.png"
    end
  end

  before :each do |example|
    if example.metadata[:zip] == false
      allow(Epzip).to receive(:zip).and_return(true)
      allow(EpubValidator).to receive(:check).and_return OpenStruct.new(valid?: true)
    end
  end

  describe "configuration" do
    it "should have set option for :paths" do
      expect(epub.settings[:paths]).to be_a Array
    end

    it "should have set option for :files" do
      expect(epub.settings[:files]).to be_a Array
    end

    it "should have #format equal to epub" do
      expect(epub.format).to eq "epub"
    end
  end

  describe "creating tmp dir", zip: false do
    it "should create the directory" do
      epub.render
      expect(File.directory?("./tmp")).to be true
    end
  end

  describe "creating paths", zip: false do
    it "should call the create_paths method" do
      expect_any_instance_of(Ebookie::Rendering::Base).to receive(:create_paths)
      expect_any_instance_of(Ebookie::Rendering::Base).to receive(:copy_files)
      expect_any_instance_of(Ebookie::Rendering::Base).to receive(:copy_images)
      expect_any_instance_of(Ebookie::Rendering::Epub).to receive(:process!)
      epub.render
    end

    it "should create the directory" do
      epub.render
      expect(File.directory?("./tmp/my-book/epub/OEBPS")).to be true
    end
  end

  describe "copying files", zip: false do
    it "should call the copy_files method" do
      expect_any_instance_of(Ebookie::Rendering::Base).to receive(:copy_files)
      epub.render
    end

    it "should create the files" do
      epub.render
      expect(File.exist?("./tmp/my-book/epub/mimetype")).to be true
      expect(File.exist?("./tmp/my-book/epub/OEBPS/epub.css")).to be true
      expect(File.exist?("./tmp/my-book/epub/META-INF/container.xml")).to be true
    end

    it "should create files from erb templates" do
      epub.render
      expect(File.exist?("./tmp/my-book/epub/OEBPS/content.opf")).to be true
      expect(File.exist?("./tmp/my-book/epub/OEBPS/toc.ncx")).to be true
    end
  end

  describe "copying images", zip: false do
    it "should call the copy_images method" do
      expect_any_instance_of(Ebookie::Rendering::Base).to receive(:copy_images)
      epub.render
    end

    it "should copy the images" do
      epub.render
      expect(File.exist?("./tmp/my-book/epub/OEBPS/images/sample.png")).to be true
    end
  end

  describe "processing the epub" do
    it "should fail if cover is not png", zip: false do
      document.config.cover = "./spec/fixtures/sample-2.pdf"
      expect do
        epub.render
      end.to raise_error
    end

    context "with local cover image" do
      it "should copy the image", zip: false do
        epub.render
        expect(File.exist?("./tmp/my-book/epub/OEBPS/images/cover.png")).to be true
      end
    end

    context "with remote cover image" do
      before do
        document.config.cover = "http://static.mailchimp.com/web/guides/getting-started-with-mailchimp/images/cover.png"
      end

      it "should copy the cover image", zip: false do
        epub.render
        expect(File.exist?("./tmp/my-book/epub/OEBPS/images/cover.png")).to be true
      end
    end

    it "should write chapters to files", zip: false do
      epub.render
      expect(File.exist?("./tmp/my-book/epub/OEBPS/introduction.html")).to be true
    end

    it "should process renderer" do
      expect_any_instance_of(Ebookie::Rendering::Epub).to receive(:process!)
      epub.render
    end

    it "should create the epub" do
      epub.render
      expect(File.exist?("./tmp/my-book.epub")).to be true
    end
  end
end
