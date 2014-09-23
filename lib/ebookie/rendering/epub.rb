require "epzip"
require "epub_validator"

module Ebookie
  module Rendering
    class Epub < Base

      set :paths, %w(OEBPS OEBPS/images META-INF)
      set :files, %w(mimetype OEBPS/epub.css OEBPS/content.opf.erb OEBPS/toc.ncx.erb META-INF/container.xml)
      set :images_dir, 'OEBPS/images'

      def copy_cover
        if File.extname(document.cover) != '.png'
          raise "Cover file is not a valid png"
        end

        FileUtils.cp document.cover, tmp_dir.join("OEBPS/images/cover.png")
      end

      def process!
        copy_cover if document.cover

        document.chapters.each do |chapter|
          render_erb_to_file template_file("OEBPS/chapter.erb"), tmp_dir.join("OEBPS/#{chapter.slug}.html"), chapter: chapter
        end

        unless Ebookie.logger.debug?
          Epzip.class_variable_set("@@zip_cmd_path", "zip -q")
        end

        zip = Epzip.zip( tmp_dir, output_path )

        validation = EpubValidator.check( output_path )
        if validation.valid?
          Ebookie.logger.info "Successfully compiled #{document.title} to epub"
        else
          Ebookie.logger.warn "Errors when compiling #{document.title} to epub"
          validation.messages.each do |m|
            Ebookie.logger.warn "~> #{m}"
          end
        end
      end

      def sanitize(content)
        match = content.match(IMAGE_SRC_REGEX).to_a.last
        content.gsub! match, "images/" if match
        content
      end

    end
  end
end