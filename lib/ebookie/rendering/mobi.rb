# frozen_string_literal: true
require "kindlegen"

module Ebookie
  module Rendering
    class Mobi < Base
      def process!
        epub = "#{document.destination}/#{document.slug}.epub"

        Epub.new(document).render unless File.exist?(epub)

        command = "#{Kindlegen.command} #{epub} -c2 -verbose -o #{document.slug}.mobi"
        converted = `#{command}`

        warnings = converted.split("\n").keep_if do |line|
          line.include?("Warning")
        end

        if warnings.length.positive?
          Ebookie.logger.warn "Warnings when compiling #{document.title} to mobi"
          warnings.each do |m|
            Ebookie.logger.warn "~> #{m}"
          end
        end
      end
    end
  end
end
