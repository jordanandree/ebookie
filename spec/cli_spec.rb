require "spec_helper"

describe Ebookie::Cli do

  describe "install" do
    before :each do
      Ebookie::Cli.new.install('tmp')
    end

    it "should create the directories for epubs" do
      expect(File.directory?('./tmp/epub')).to be true
      expect(File.directory?('./tmp/epub/OEBPS')).to be true
      expect(File.directory?('./tmp/epub/META-INF')).to be true
    end

    it "should create the directories for pdfs" do
      expect(File.directory?('./tmp/pdf')).to be true
    end

    it "should create the files for epubs" do
      expect(File.exists?('./tmp/epub/mimetype')).to be true
      expect(File.exists?('./tmp/epub/OEBPS/chapter.erb')).to be true
      expect(File.exists?('./tmp/epub/OEBPS/content.opf.erb')).to be true
      expect(File.exists?('./tmp/epub/OEBPS/epub.css')).to be true
      expect(File.exists?('./tmp/epub/OEBPS/toc.ncx.erb')).to be true
      expect(File.exists?('./tmp/epub/META-INF/container.xml')).to be true
    end

    it "should create the files for pdfs" do
      expect(File.exists?('./tmp/pdf/cover.html.erb')).to be true
      expect(File.exists?('./tmp/pdf/document.html.erb')).to be true
      expect(File.exists?('./tmp/pdf/pdf.css')).to be true
    end
  end

end