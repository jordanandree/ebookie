require "thor"
require "pathname"

module Ebookie
  class Cli < Thor
    include Thor::Actions
    add_runtime_options!

    desc "install DIRECTORY", "install template files to DIRECTORY"
    def install(directory)
      exec_dir = Pathname.new(Dir.pwd)
      templates_dir = Pathname.new(File.expand_path('../templates', __FILE__))

      Ebookie::Cli.source_root templates_dir

      directory templates_dir, exec_dir.join(directory)
    end

  end
end