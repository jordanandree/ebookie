require "phantomjs"
require "prawn"
require "prawn/templates"
require "pdf-reader"

module Ebookie
  module Rendering
    class PDF < Base

      set :files, %w(pdf.css document.html.erb)
      set :paths, %w(images)
      set :images_dir, 'images'

      def pdf_options
        {
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
        ghostscript_path = `which gs`.chomp
        phantom_script = File.expand_path("../html2pdf.js", __FILE__)

        tmp_path = tmpdir.join("document.pdf")
        system "#{Phantomjs.path} #{phantom_script} '#{tmpdir.join('document.html')}' #{tmp_path}"
        pages = []

        reader = ::PDF::Reader.new(tmp_path)

        reader.pages.each_with_index do |page, idx|
          output_file = tmpdir.join("page-#{idx}.pdf")

          gs_opts = "-q -dBATCH -dNOPAUSE \
                    -sDEVICE=pdfwrite \
                    -dFirstPage=#{idx+1} \
                    -dLastPage=#{idx+1} \
                    -sOutputFile=#{output_file}"
          system("#{ghostscript_path} #{gs_opts} #{tmp_path}")

          colors = `#{ghostscript_path} -q -o - -sDEVICE=inkcov #{output_file}`
          colors = colors.split(" ").uniq[0..-3]
          unless colors.length == 1 && colors.first == "0.00000"
            pages << idx.to_s
          end
        end

        Prawn::Document.generate(output, pdf_options) do |pdf|
          pages.each do |idx|
            pdf.start_new_page( template: tmpdir.join("page-#{idx}.pdf") )
          end
        end
      end

      def sanitize(content)
        content.gsub! /src=('|")([a-zA-Z0-9\.]+)('|")/, 'src=\1' + tmpdir.to_s + '/images/\2\3'
        content
      end

    end
  end
end