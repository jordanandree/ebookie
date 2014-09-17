require "prawn"
require "prawn/templates"
require "pdf-reader"

module Ebookie
  module Rendering
    class PDF < Base

      set :files, %w(pdf.css document.html.erb cover.html.erb)
      set :paths, %w(images)
      set :images_dir, 'images'

      def after_initialize
        @phantomjs_path = `which phantomjs`.chomp
        raise "PhantomJS not installed" unless @phantomjs_path

        @ghostscript_path = `which gs`.chomp
        raise "GhostScript not installed" unless @ghostscript_path

        @tmp_path = tmpdir.join("document.pdf")
        @pages = []

        @pdf_options = {
          :info => {
            :Title        => document.title,
            :Author       => document.creator,
            :Subject      => document.subject,
            :Keywords     => document.subject,
            :Creator      => document.creator,
            :Producer     => document.creator,
            :CreationDate => document.date
          }
        }
      end

      def process!
        if File.extname(document.cover) != '.pdf'
          FileUtils.cp document.cover, tmpdir.join('images', File.basename(document.cover))
          cover_path = tmpdir.join("cover.pdf")

          convert_page(tmpdir.join('cover.html'), cover_path)
          @pdf_options.merge!(template: cover_path)
        end

        convert_page(tmpdir.join('document.html'), @tmp_path)

        ::PDF::Reader.new(@tmp_path).pages.each_with_index do |page, idx|
          prune_blank_page(idx)
        end

        Prawn::Document.generate(output, @pdf_options) do |pdf|
          @pages.each do |idx|
            pdf.start_new_page( template: tmpdir.join("page-#{idx}.pdf") )
          end
        end
      end

      def sanitize(content)
        content.gsub! /src=('|")([a-zA-Z0-9\.]+)('|")/, 'src=\1' + tmpdir.to_s + '/images/\2\3'
        content
      end

      def convert_page(input_path, output_path)
        script = File.expand_path("../html2pdf.js", __FILE__)
        system [@phantomjs_path, script, input_path, output_path].join(' ')
      end

      def prune_blank_page(index)
        output_file = tmpdir.join("page-#{index}.pdf")
        options = ["-q",
                   "-dBATCH",
                   "-dNOPAUSE",
                   "-sDEVICE=pdfwrite",
                   "-dFirstPage=#{index+1}",
                   "-dLastPage=#{index+1}",
                   "-sOutputFile=#{output_file}"]

        system [@ghostscript_path, options.join(' '), @tmp_path].join(' ')

        colors = `#{@ghostscript_path} -q -o - -sDEVICE=inkcov #{output_file}`
        colors = colors.split(" ").uniq[0..-3]
        unless colors.length == 1 && colors.first == "0.00000"
          @pages << index.to_s
        end
      end

    end
  end
end