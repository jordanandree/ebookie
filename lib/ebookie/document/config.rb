module Ebookie
  module Document
    class Config

      attr_accessor :title
      attr_accessor :creator
      attr_accessor :publisher
      attr_accessor :rights
      attr_accessor :subject
      attr_accessor :language
      attr_accessor :source
      attr_accessor :date
      attr_accessor :output
      attr_accessor :cover

      def date
        @date || Time.now.strftime("%F")
      end

      def language
        @language || "en-US"
      end

    end
  end
end