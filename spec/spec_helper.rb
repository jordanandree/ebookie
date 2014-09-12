require 'bundler/setup'
Bundler.setup

require "ebookie"
require "pry-byebug"

RSpec.configure do |config|

  config.expect_with :rspec do |expectations|
    # Enable only the newer, non-monkey-patching expect syntax.
    # For more details, see:
    #   - http://myronmars.to/n/dev-blog/2012/06/rspecs-new-expectation-syntax
    expectations.syntax = :expect
  end

end