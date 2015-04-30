require "spec_helper"

describe Ebookie::Rendering::Pdf do
  let(:document) { Ebookie::Document.new("My Book") }
  let(:pdf) { Ebookie::Rendering::Pdf.new(document) }

  before :each do |example|
    if example.metadata[:zip] == false
      allow(Ebookie::Rendering::Pdf).to receive(:convert_page)
      allow(PDF::Reader).to receive(:new).and_return( OpenStruct.new(pages: {}) )
      allow(CombinePDF).to receive(:save)
    end
  end

  before do
    document.chapter "Introduction", "<p>This is my foo bar</p>"
    document.chapter "Links", "<p><a href='http://google.com'>this is a link</a></p>"
    document.chapter "Image", "<img src='sample.png' alt='Image' />"
    document.image "./spec/fixtures/sample.png"

    document.config.destination = './tmp/'
  end

  describe "process! method" do
    context 'pdf with no cover' do
      let(:document) { Ebookie::Document.new("My Book") }

      it "should create the pdf" do
        pdf.render
        expect(File.exists?('./tmp/my-book.pdf')).to be true
      end
    end

    context 'pdf with cover' do
      let(:document) { Ebookie::Document.new("My Book") }

      before :each do
        document.config.cover = './spec/fixtures/sample-2.pdf'
      end

      context 'with local png cover' do
        before :each do
          document.config.cover = './spec/fixtures/sample-2.png'
        end

        it "should copy the image", zip: false do
          pdf.render
          expect(File.exists?('./tmp/my-book/pdf/images/sample-2.png')).to be true
        end

        it "should call the convert_cover method", zip: false do
          expect(pdf).to receive(:convert_cover)
          pdf.render
        end

        it "should generate the html page", zip: false do
          pdf.render
          expect(File.exists?('./tmp/my-book/pdf/cover.html')).to be true
        end

        it "should create the cover", zip: false do
          pdf.render
          expect(File.exists?('./tmp/my-book/pdf/cover.pdf')).to be true
        end
      end

      context 'with remote png cover' do
        before :each do
          document.config.cover = 'http://static.mailchimp.com/web/guides/getting-started-with-mailchimp/images/cover.png'
        end

        it "should copy the image", zip: false do
          pdf.render
          expect(File.exists?('./tmp/my-book/pdf/images/cover.png')).to be true
        end
      end

      context 'with remote pdf cover' do
        before :each do
          document.config.cover = 'http://static.mailchimp.com/web/guides/common-rookie-mistakes/package/common-rookie-mistakes.pdf'
        end

        it "should copy the image", zip: false do
          pdf.render
          expect(File.exists?('./tmp/my-book/pdf/cover.pdf')).to be true
        end
      end

      it "should create the pdf" do
        pdf.render
        expect(File.exists?('./tmp/my-book.pdf')).to be true
      end
    end
  end

end