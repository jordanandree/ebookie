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

      def title
        @config.title
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

    end
  end
end