# Ebookie

Generate PDF, ePub, and Mobi eBooks

[Example project](./example)

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
document = Ebookie::Document.new "My eBook" # Title
```

Configure it:

```ruby
document.configure do |config|
  config.cover        = './path/to/cover.png'  # Cover image
  config.destination  = './ebook/'             # Ouput for ePub, Mobi, PDF
  config.subject      = "Introductions"
  config.source       = "http://google.com"
end
```

Add a chapter:

```ruby
# You can pass a string for the content
document.chapter 'Getting Started', "All about how to get started"

# You can also give it an html file to read
document.chapter 'Getting Started', Pathname.new("path/to/myfile.html")
```

Add an image:

```ruby
# Relative or absolute path for image to be copied
document.image './path/to/image.png'

# Chapters can reference images with html:
document.chapter "My Cool Image", "<img src='image.png' alt='image' />"
```

Render the document:

```ruby
# ePub
document.render_epub

# Mobi
document.render_mobi

# PDF
document.render_pdf
```

#### Install templates for customization:

```bash
$ ebookie install ./path/to/templatees
```

Then configure the document:

```ruby
document.config.template = './path/to/templates'
```

## Contributing

1. Fork it ( http://github.com/mailchimp/ebookie/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
