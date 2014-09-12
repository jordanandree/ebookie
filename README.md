# Ebookie

Generate PDF, ePub, and Mobi eBooks

## Installation

Add this line to your application's Gemfile:

    gem 'ebookie'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ebookie

## Usage

Create a new document:

```ruby
document = Ebookie::Document.new "My eBook"
```

Configure it:

```ruby
document.configure do |config|
  config.subject = "Introductions"
  config.source  = "http://google.com"
end
```

Add a chapter:

```ruby
# You can pass a string for the content
document.chapter 'Getting Started', "All about how to get started"

# You can also give it an html file to read
document.chapter 'Getting Started', Pathname.new("path/to/myfile.html")
```

TODO

- Render out to different formats
- Handle png images for ePubs
- Drop phantomjs for PDF generation

## Contributing

1. Fork it ( http://github.com/mailchimp/ebookie/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
