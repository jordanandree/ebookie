# frozen_string_literal: true
require "epzip"
require "epub_validator"

module Ebookie
  module Rendering
    class Epub < Base
      set :paths, %w[OEBPS OEBPS/images META-INF]
      set :files, %w[mimetype OEBPS/epub.css OEBPS/content.opf.erb OEBPS/toc.ncx.erb META-INF/container.xml]
      set :images_dir, "OEBPS/images"

      def copy_cover
        if File.extname(document.cover) != ".png"
          raise "Cover file is not a valid png"
        end

        borrow document.cover.to_s, to: tmp_dir.join("OEBPS/images/cover.png")
      end

      def process!
        copy_cover if document.cover

        document.chapters.each do |chapter|
          render_erb_to_file template_file("OEBPS/chapter.erb"), tmp_dir.join("OEBPS/#{chapter.slug}.html"), chapter: chapter
        end

        unless Ebookie.logger.debug?
          Epzip.class_variable_set("@@zip_cmd_path", "zip -q")
        end

        zip = Epzip.zip(tmp_dir, output_path)

        validation = EpubValidator.check(output_path)
        if validation.valid?
          Ebookie.logger.info "Successfully compiled #{document.title} to epub"
        else
          Ebookie.logger.warn "Errors when compiling #{document.title} to epub"
          validation.messages.each do |m|
            Ebookie.logger.warn "~> #{m}"
          end
        end
      end

      def sanitize(html)
        html = html.dup
        {
          "<figure>"      => '<span class="figure">',
          "</figure>"     => "</span>",
          "<figcaption>"  => '<span class="figcaption">',
          "</figcaption>" => "</span>"
        }.each do |k, v|
          html.gsub! k, v
        end

        sanitize_html clean_images(html, Pathname.new("images"))
      end
    end
  end
end
