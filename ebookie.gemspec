# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ebookie/version'

Gem::Specification.new do |spec|
  spec.name          = 'ebookie'
  spec.version       = Ebookie::VERSION
  spec.authors       = ['Jordan Andree']
  spec.email         = ['jordanandree@gmail.com']
  spec.summary       = %q{Generate PDF, ePub, and Mobi eBooks}
  spec.description   = %q{Generate PDF, ePub, and Mobi eBooks}
  spec.homepage      = 'https://github.com/jordanandree/ebookie'
  spec.license       = 'MIT'

  spec.files         = Dir['LICENSE.txt', 'README.md', 'lib/**/*']
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake',    '~> 10.0'
  spec.add_development_dependency 'rspec',   '~> 3.0'

  spec.add_runtime_dependency 'epzip',               '~> 0.8.0', '>= 0.8.0'
  spec.add_runtime_dependency 'epub_validator',      '~> 1.1.0', '>= 1.1.0'
  spec.add_runtime_dependency 'kindlegen',           '~> 2.9.1', '>= 2.9.1'
  spec.add_runtime_dependency 'wkhtmltopdf-binary',  '~> 0.9.9', '>= 0.9.9'
  spec.add_runtime_dependency 'combine_pdf',         '~> 0.1.0', '>= 0.1.0'
  spec.add_runtime_dependency 'pdf-reader',          '~> 1.3.3', '>= 1.3.3'
  spec.add_runtime_dependency 'borrower',            '~> 0.9.1', '>= 0.9.1'
  spec.add_runtime_dependency 'thor',                '~> 0.19',  '>= 0.19'
end
