module Ebookie
  module Document
    class Base

      attr_reader :chapters, :config

      def initialize(title)
        @chapters = []
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

    end
  end
end