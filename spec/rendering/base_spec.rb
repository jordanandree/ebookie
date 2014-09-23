require "spec_helper"

describe Ebookie::Rendering::Base do
  let(:document) { Ebookie::Document.new("My Book") }
  let(:base) { Ebookie::Rendering::Epub.new(document) }

  describe "#template_dir" do
    it "should be a path" do
      expect(base.template_dir).to be_a Pathname
    end
  end

  describe "#template_file" do
    context "without custom template" do
      it "should return default file" do
        expect(base.template_file('mimetype').to_s).to match %r(lib/ebookie/templates/epub/mimetype)
      end
    end

    context 'with a custom template' do
      before :each do
        FileUtils.mkdir_p './tmp/template/epub/OEBPS'
        document.config.template = './tmp/template'
        document.config.destination = './tmp/'

        document.chapter "Foo", "Bar"

        File.open "./tmp/template/epub/OEBPS/epub.css", "w+" do |f|
          f.write 'foo'
        end
      end

      it "should return a custom file" do
        expect(base.template_file('OEBPS/epub.css').to_s).to match %r(tmp/template/epub/OEBPS/epub.css)
      end

      it "should implement custom file when rendered" do
        base.render
        expect(File.read(base.tmp_dir.join('OEBPS/epub.css'))).to eq "foo"
      end
    end
  end

end