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
      attr_accessor :destination
      attr_accessor :cover

      def date
        @date || Time.now.strftime("%F")
      end

      def language
        @language || "en-US"
      end

      def cover=(path)
        if File.exists? path
          if %w(.png .pdf).include? File.extname(path)
            @cover = Pathname.new(path)
          else
            Ebookie.logger.warn "Cover file is not a valid"
          end
        else
          Ebookie.logger.warn "Cover file does not exist"
        end
      end

      def slug
        title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
      end

    end
  end
end