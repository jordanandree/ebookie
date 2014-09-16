require "spec_helper"

describe Ebookie::Document::Image do
  let(:valid_image) { Ebookie::Document::Image.new('./spec/fixtures/sample.png') }
  let(:invalid_image) { Ebookie::Document::Image.new('./spec/fixtures/sample.jpg') }

  context "with a valid image file" do
    it "should set @file with the image" do
      expect(valid_image.file).to be_a Pathname
    end

    it "should have an existing file" do
      expect(File.exists?(valid_image.file)).to be true
    end
  end
  context "with an invalid image file" do
    it "should not set @file" do
      expect(invalid_image.file).to be nil
    end
  end

  describe "#basename instance method" do
    it "should return the file basename" do
      expect(valid_image.basename).to eq "sample.png"
    end
  end

end