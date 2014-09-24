require "ostruct"

module Ebookie
  module Rendering
    class Base
      IMAGE_SRC_REGEX = /src=['|"]((\/?.+\/)*)?(.+?[\.]+.+?)['|"]/xi

      attr_reader :document

      def initialize(document)
        @document = document

        after_initialize if respond_to?(:after_initialize)
      end

      class << self
        def inherited(subclass)
          subclass.class_eval do
            attr_reader :settings
          end

          subclass.instance_eval do
            define_method :settings do
              @@settings.send(format) || {}
            end
          end
        end

        def set(key, val)
          @@settings ||= OpenStruct.new

          format_options = @@settings.send(format) || {}
          @@settings.send "#{format}=", format_options.merge({key => val})
        end

        def format
          self.name.split("::").last.downcase
        end
      end

      def render
        throw "Output path required" unless document.destination

        FileUtils.mkdir_p(tmp_dir) unless File.exists?(tmp_dir)

        create_paths if settings.keys.include?(:paths) && settings[:paths]
        copy_files if settings.keys.include?(:files) && settings[:files]
        copy_images if document.images.any? && settings[:images_dir]

        FileUtils.mkdir_p(document.destination) unless File.exists?(document.destination)

        process!
        return output_path
      end

      def template_file(path)
        custom_template_dir = Pathname.new(document.template) if document.template

        if document.template && File.exists?(custom_template_dir.join(format, path))
          custom_template_dir.join(format, path)
        else
          template_dir.join(path)
        end
      end

      def render_erb_to_file(template, filepath, locals={})
        locals.merge! document: document, renderer: self

        locals_struct = OpenStruct.new(locals).instance_eval { binding }
        contents = ERB.new(File.read(template)).result(locals_struct)

        write_contents_to_file(contents, filepath)
      end

      def tmp_dir
        Pathname.new(File.expand_path("../../../../tmp/#{document.config.slug}/#{format}", __FILE__))
      end

      def template_dir
        Pathname.new(File.expand_path("../../templates/#{format}", __FILE__))
      end

      def format
        self.class.format
      end

      def output_path
        Pathname.new(document.destination).join("#{document.config.slug}.#{format}").to_s
      end

      def sanitize_html(html)
        {
          /&rsquo;|&lsquo;/ => "'",
          /&rdquo;|&ldquo;/ => "\"",
          "’"               => "'",
          "&#58;"           => ":"
        }.each do |k,v|
          html.gsub! k, v
        end

        html
      end

      def clean_images(html, new_path)
        html.each_line do |line|
          old_line = line.dup
          matches = line.match(IMAGE_SRC_REGEX).to_a
          next unless matches.any?

          # remove folder
          line.gsub! matches[2], "" if matches[2]

          # set our folder
          line.gsub! matches[3], new_path.join(matches[3]).to_s

          html.gsub! old_line, line
        end
      end

      private

        def create_paths
          settings[:paths].each do |path|
            FileUtils.mkdir_p tmp_dir.join(path)
          end
        end

        def copy_images
          document.images.each do |image|
            FileUtils.cp image.file, tmp_dir.join(settings[:images_dir], image.basename)
          end
        end

        def copy_files
          settings[:files].each do |file|
            if File.extname(file) == '.erb' && ext = File.extname(file)
              render_erb_to_file template_file(file), tmp_dir.join(file.gsub(ext, ''))
            else
              FileUtils.cp template_file(file), tmp_dir.join(file)
            end
          end
        end

        def write_contents_to_file(contents, filepath, mode="w+")
          File.open(filepath, mode) do |handle|
            handle.write(contents)
            handle.close
          end
        end

    end
  end
end