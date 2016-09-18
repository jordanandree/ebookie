# frozen_string_literal: true
module Ebookie
  require "ebookie/version"
  require "ebookie/document"
  require "ebookie/rendering"
  require "logger"

  def self.logger
    @logger ||= Logger.new(STDOUT)
    @logger.level = if ENV["LOG_LEVEL"] && log_level = Logger.const_get(ENV["LOG_LEVEL"])
                      log_level
                    else
                      Logger::WARN
                    end
    @logger
  end
end
