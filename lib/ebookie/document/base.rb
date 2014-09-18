module Ebookie
  module Document
    class Base

      attr_reader :chapters, :images, :config

      def initialize(title)
        @chapters = []
        @images = []

        @config = Config.new
        @config.title = title
      end

      def configure(&block)
        yield @config
      end

      def chapter(title, content)
        @chapters << Chapter.new(title, content)
      end

      def image(file)
        @images << Image.new(file)
      end

      def render_pdf
        Rendering::Pdf.new(self).render
      end

      def render_epub
        Rendering::Epub.new(self).render
      end

      def render_mobi
        Rendering::Mobi.new(self).render
      end

      def method_missing(meth, *args)
        if @config.respond_to?(meth)
          @config.send(meth, *args)
        else
          super
        end
      end

    end
  end
end