module Ebookie
  module Document
    class Chapter < Struct.new(:title, :content)

      attr_reader :title

      def initialize(title, content)
        @title = title
        @content = content

        super title, content
      end

      def content
        if @content.is_a? Pathname
          @content.read
        else
          @content
        end
      end

      def slug
        title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
      end

    end
  end
end