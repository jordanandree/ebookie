module Ebookie
  require "ebookie/version"
  require "ebookie/document"
  require "ebookie/rendering"
  require "logger"

  def self.logger
    @logger ||= Logger.new(STDOUT)
    if ENV['LOG_LEVEL'] && log_level = Logger.const_get(ENV['LOG_LEVEL'])
      @logger.level = log_level
    else
      @logger.level = Logger::WARN
    end
    @logger
  end
end
