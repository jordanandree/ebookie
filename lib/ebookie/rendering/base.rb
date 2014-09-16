require "ostruct"

module Ebookie
  module Rendering
    class Base
      @@settings = {}

      attr_reader :document

      def initialize(document)
        @document = document

        settings.each do |key, val|
          self.class.class_eval do
            attr_reader key
          end

          instance_variable_set("@#{key}", val)
        end
      end

      def self.inherited(subclass)
        subclass.class_eval do
          attr_reader :settings
        end

        subclass.instance_eval do
          define_method :settings do
            @@settings[format] || {}
          end
        end
      end

      def self.set(key, val)
        @@settings[format] ||= {}
        @@settings[format][key] = val
      end

      def self.format
        self.name.split("::").last.downcase
      end

      def template?
        File.directory? templatedir
      end

      def templatedir
        Pathname.new(File.expand_path("../../templates/#{format}/", __FILE__))
      end

      def render
        throw "Output path required" unless document.config.output

        create_tmpdir

        create_paths if respond_to?(:paths) && paths
        copy_files if respond_to?(:files) && files

        process! if respond_to?(:process!)
      end

      def create_tmpdir
        FileUtils.mkdir_p tmpdir
      end

      def create_paths
        paths.each do |path|
          FileUtils.mkdir_p tmpdir.join(path)
        end
      end

      def copy_files
        files.each do |file|
          if File.extname(file) == '.erb' && ext = File.extname(file)
            render_erb_to_file templatedir.join(file), tmpdir.join(file.gsub(ext, ''))
          else
            FileUtils.cp templatedir.join(file), tmpdir.join(file)
          end
        end
      end

      def render_erb_to_file(template, filepath, locals={})
        locals.merge! document: document

        locals_struct = OpenStruct.new(locals).instance_eval { binding }
        contents = ERB.new(File.read(template)).result(locals_struct)

        write_contents_to_file(contents, filepath)
      end

      def write_contents_to_file(contents, filepath, mode="w+")
        File.open(filepath, mode) do |handle|
          handle.write(contents)
          handle.close
        end
      end

      def tmpdir
        Pathname.new(File.expand_path("../../../../tmp/#{document.config.slug}/#{format}", __FILE__))
      end

      def format
        self.class.format
      end

      def output
        Pathname.new(document.config.output).join("#{document.config.slug}.#{format}").to_s
      end

      def logger
        @logger ||= Logger.new(STDOUT)
        @logger.level = ENV['DEBUG'] ? Logger::DEBUG : Logger::WARN
        @logger
      end

    end
  end
end