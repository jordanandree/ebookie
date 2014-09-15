require "epzip"
require "epub_validator"

module Ebookie
  module Rendering
    class Epub < Base

      set :paths, %w(OEBPS OEBPS/images META-INF)
      set :files, %w(mimetype OEBPS/epub.css OEBPS/content.opf.erb OEBPS/toc.ncx.erb META-INF/container.xml)

      def process!
        document.chapters.each do |chapter|
          write_contents_to_file chapter_layout(chapter), tmpdir.join("OEBPS/#{chapter.slug}.html")
        end

        Epzip.zip( tmpdir, output )

        validation = EpubValidator.check( output )
        if validation.valid?
          puts "Successfully compiled #{document.title} to epub"
        else
          puts "Errors when compiling #{document.title} to epub"
          validation.messages.each do |m|
            puts "~> #{m}"
          end
        end
      end

      def chapter_layout(chapter)
        layout = <<EOF
<?xml version="1.0" encoding="utf-8"?>
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>#{chapter.title}</title>
  </head>
  <body><div>#{chapter.content}</div></body>
</html>
EOF
      end

    end
  end
end