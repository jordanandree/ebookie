require "prawn"
require "prawn/templates"
require "pdf-reader"

module Ebookie
  module Rendering
    class Pdf < Base

      set :files, %w(pdf.css document.html.erb)
      set :paths, %w(images)
      set :images_dir, 'images'

      def after_initialize
        @phantomjs_path = `which phantomjs`.chomp
        raise "PhantomJS not installed" unless @phantomjs_path

        @ghostscript_path = `which gs`.chomp
        raise "GhostScript not installed" unless @ghostscript_path

        @tmp_path = tmp_dir.join("document.pdf")
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

        settings[:files] << 'cover.html.erb' if convert_cover?
      end

      def process!
        convert_page(tmp_dir.join('document.html'), @tmp_path)

        ::PDF::Reader.new(@tmp_path).pages.each_with_index do |page, idx|
          prune_blank_page(idx)
        end

        if convert_cover?
          cover_path = convert_cover
          @pdf_options.merge!(template: cover_path)
        else
          @pdf_options.merge!(template: document.cover)
        end

        unless document.cover
          @pdf_options.merge!(template: tmp_dir.join("page-0.pdf"))
          @pages = @pages.drop(1)
        end

        Prawn::Document.generate(output_path, @pdf_options) do |pdf|
          @pages.each do |idx|
            pdf.start_new_page( template: tmp_dir.join("page-#{idx}.pdf") )
          end
        end
      end

      def sanitize(html)
        html = html.dup
        {
          "—" => "&mdash;"
        }.each do |k,v|
          html.gsub! k, v
        end

        sanitize_html clean_images(html, tmp_dir.join("images"))
      end

      def convert_page(input_path, output_path, args=[])
        script = File.expand_path("../html2pdf.js", __FILE__)
        command = [@phantomjs_path, script, input_path, output_path]
        system (command + args).join(' ')
      end

      def convert_cover?
        document.cover && File.extname(document.cover) != '.pdf'
      end

      def convert_cover
        borrow document.cover.to_s, to: tmp_dir.join('images', File.basename(document.cover))
        cover_path = tmp_dir.join("cover.pdf")

        margins = %w(0in 0in 0in 0in)
        convert_page(tmp_dir.join('cover.html'), cover_path, margins)

        return cover_path
      end

      def prune_blank_page(index)
        output_file = tmp_dir.join("page-#{index}.pdf")
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