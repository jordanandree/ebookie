require "combine_pdf"
require "pdf-reader"

module Ebookie
  module Rendering
    class Pdf < Base

      set :files, %w(pdf.css document.html.erb)
      set :paths, %w(images)
      set :images_dir, 'images'

      def after_initialize
        @wkhtmltopdf_path = Gem.bin_path("wkhtmltopdf-binary-edge")

        @ghostscript_path = `which gs`.chomp
        raise "GhostScript not installed" unless @ghostscript_path

        @tmp_path = tmp_dir.join("document.pdf")
        @pages = []

        settings[:files] << 'cover.html.erb' if convert_cover?
      end

      def process!
        convert_page(tmp_dir.join('document.html'), @tmp_path)

        ::PDF::Reader.new(@tmp_path).pages.each_with_index do |page, idx|
          prune_blank_page(idx)
        end

        if document.cover
          if File.extname(document.cover) != '.pdf'
            cover_path = convert_cover
            @pages.unshift cover_path
          else
            borrow document.cover.to_s, to: tmp_dir.join('cover.pdf')
            @pages.unshift tmp_dir.join('cover.pdf')
          end
        end

        pdf = CombinePDF.new
        @pages.compact.each do |page|
          pdf << CombinePDF.new(page)
        end
        pdf.save output_path
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
        args << "--quiet"
        args << "--page-size Letter"
        args << "--title '#{document.title}'"
        command = [@wkhtmltopdf_path] + args
        command << input_path
        command << output_path
        system command.join(' ')
      end

      def convert_cover?
        document.cover && File.extname(document.cover) != '.pdf'
      end

      def convert_cover
        borrow document.cover.to_s, to: tmp_dir.join('images', File.basename(document.cover))
        cover_path = tmp_dir.join("cover.pdf")

        margins = ['--margin-top 0', '--margin-bottom 0', '--margin-left 0', '--margin-right 0']
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
          @pages << tmp_dir.join("page-#{index}.pdf")
        end
      end

    end
  end
end