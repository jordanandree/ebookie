require "ebookie/document/config"
require "ebookie/document/base"
require "ebookie/document/chapter"
require "ebookie/document/image"

module Ebookie
  module Document
    class << self

      def new(*args)
        Base.new(*args)
      end

    end
  end
end