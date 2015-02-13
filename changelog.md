- Added example project with test chapters, images, and cover
- Fixed character encoding for special quotes and Apple cmd key symbols

## 0.2.3
- copy remote covers locally for pdfs

## 0.2.2
- added borrower gem for copy image files
- support for remote image files
- support for remote cover files

## 0.2.1
- Fix sanitization of html characters
- Fix image paths replacement

## 0.2.0
- custom templates support
- added cli command to copy template files locally (`ebookie install DIRECTORY`)
- allow pdf file type for PDF generator
- fixed image replacement matcher for image paths
- fixed copy_images task to not run if no images are set

## 0.1.2
- updated output directory config setter/getter with name 'destination'
- create the destination directory if it doesn't exist when processing renderer
- calling a renderer will return the output_path of the rendered file
- dropped Struct inheritance for Chapter class
- move logger require to base module

## 0.1.1
- Updated PDF renderer with no margins for cover

## 0.1.0
- Initial minor release