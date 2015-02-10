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

## PhantomJS Installation on Mac OS X

There is a bug in PhantomJS on Mac OS X that doesn't render an HTML page as selectable text. It will be fixed in PhantomJS 2.0, so for now you'll have to apply a patch when installing with Homebrew.

First, update homebrew formulae:

```bash
$ brew update
```

If you already have PhantomJS installed, then remove it:

```bash
$ brew uninstall phantomjs
```

Next, the PhantomJS formula needs to be edited to apply a patch that fixes native text rendering in Mac OS X:

```bash
$ brew edit phantomjs
```

Add these lines after any other `patches` blocks and before the `def install` method:

```ruby
patch do
  url "https://github.com/ariya/phantomjs/commit/0663263bfa748b0933d7eff4b5e49d9ed97bcc84.diff"
  sha1 "ac0f7f967d8b5a3a49c8f6654f8182ffb99391f5"
end
```

Finally, reinstall PhantomJS from source via homebrew and go do something else since your computer will be at 100% CPU for about 30 minutes:

```bash
$ brew install phantomjs --build-from-source
```

## Contributing

1. Fork it ( http://github.com/mailchimp/ebookie/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
