require "epzip"
require "epub_validator"

module Ebookie
  module Rendering
    class Epub < Base

      set :paths, %w(OEBPS OEBPS/images META-INF)
      set :files, %w(mimetype OEBPS/epub.css OEBPS/content.opf.erb OEBPS/toc.ncx.erb META-INF/container.xml)

      def process!
        document.chapters.each do |chapter|
          render_erb_to_file templatedir.join("OEBPS/chapter.erb"), tmpdir.join("OEBPS/#{chapter.slug}.html"), chapter: chapter
        end

        unless logger.debug?
          Epzip.class_variable_set("@@zip_cmd_path", "zip -q")
        end

        zip = Epzip.zip( tmpdir, output )

        validation = EpubValidator.check( output )
        if validation.valid?
          logger.info "Successfully compiled #{document.title} to epub"
        else
          logger.warn "Errors when compiling #{document.title} to epub"
          validation.messages.each do |m|
            logger.warn "~> #{m}"
          end
        end

        return zip
      end

    end
  end
end