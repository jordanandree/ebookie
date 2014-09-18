module Ebookie
  module Document
    class Chapter

      attr_accessor :title, :content

      def initialize(title, content)
        @title = title
        @content = content
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