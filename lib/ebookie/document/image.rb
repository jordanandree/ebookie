# frozen_string_literal: true
module Ebookie
  module Document
    class Image
      attr_reader :file

      def initialize(filepath)
        self.file = filepath
      end

      def file=(path)
        if File.exist?(path) || path.match(/http[s]?:\/\//)
          if File.extname(path) == ".png"
            @file = Pathname.new(path)
          else
            Ebookie.logger.warn "Image file is not a valid png for '#{path}'"
          end
        else
          Ebookie.logger.warn "Image file does not exist for '#{path}'"
        end
      end

      def basename
        File.basename(file) if file
      end
    end
  end
end
