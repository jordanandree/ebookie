require 'bundler/setup'
Bundler.setup

require "ebookie"

if RUBY_VERSION > "1.9.3"
  require "pry-byebug"
else
  require "pry-debugger"
end

RSpec.configure do |config|

  config.expect_with :rspec do |expectations|
    # Enable only the newer, non-monkey-patching expect syntax.
    # For more details, see:
    #   - http://myronmars.to/n/dev-blog/2012/06/rspecs-new-expectation-syntax
    expectations.syntax = :expect
  end

  config.after :each do
    FileUtils.rm_rf "./tmp" unless ENV['DEBUG']
  end

end