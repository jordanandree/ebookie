require "kindlegen"

module Ebookie
  module Rendering
    class Mobi < Base

      def process!
        epub = "#{document.config.output}/#{document.config.slug}.epub"

        if !File.exists?(epub)
          Epub.new(document).render
        end

        command = "#{Kindlegen.command} #{epub} -c2 -verbose -o #{document.config.slug}.mobi"
        converted = `#{command}`

        warnings = converted.split("\n").keep_if do |line|
          line.include?("Warning")
        end

        if warnings.length > 0
          puts "Warnings when compiling #{document.title} to mobi"
          warnings.each do |m|
            puts "~> #{m}"
          end
        end
      end

    end
  end
end