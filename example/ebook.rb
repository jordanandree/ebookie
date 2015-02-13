#!/usr/bin/env ruby
#
# To run me, simply cd to ./example and run:
# 
#   ./ebookie.rb {format}
# 
# {format} can be either pdf, epub, or mobi
# 

require "bundler/setup"
require "ebookie"
require "kramdown"

# Setup the Ebookie Document with a Title
document = Ebookie::Document.new "Getting Started with MailChimp"

# Configure the cover and metadata
document.configure do |config|
  config.cover        = './cover.png'                   # Cover image
  config.destination  = File.expand_path('../output/', __FILE__) # Ouput path
  config.subject      = "Getting Started with MailChimp"        # Book subject
  config.source       = "http://mailchimp.com/resources/guides/getting-started-with-mailchimp"
end

# Add chapters in ./chapters/ directory
Dir['./chapters/*.md'].each do |file|

  # Parse the chapter title from the file name
  chapter_title = File.basename(file).sub(File.extname(file), '').gsub(/\d|-/, '')

  # Convert the chapter contents from markdown to html
  chapter_contents = Kramdown::Document.new(File.read(file)).to_html

  # Add the chapter
  document.chapter chapter_title, chapter_contents

end

# Add images in ./images/ directory
Dir['./images/*.png'].each do |image|

  # Relative or absolute path for image to be copied
  document.image image

end

format = ARGV[0] || 'pdf'

if document.respond_to? "render_#{format}"
  # Render the format
  puts "~> Generating #{format}"
  document.send "render_#{format}"
  puts "~> Created #{format}"
else
  puts "Format type '#{format}' must be pdf, epub, or mobi"
end