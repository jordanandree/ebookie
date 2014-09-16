module Ebookie
  require "ebookie/version"
  require "ebookie/document"
  require "ebookie/rendering"

  def self.logger
    @logger ||= Logger.new(STDOUT)
    @logger.level = ENV['DEBUG'] ? Logger::DEBUG : Logger::WARN
    @logger
  end
end
