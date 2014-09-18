// html2pdf.js
var page = new WebPage();
var system = require("system");

// change the paper size to letter, add some borders
var pageOptions = {
  format:      "Letter",
  orientation: "portrait",
  margin: {
    left:   "1.0in",
    right:  "1.0in",
    top:    "1.5in",
    bottom: "1.5in"
  }
};

if( typeof system.args[3] != 'undefined' )
  pageOptions.margin.top = system.args[3];

if( typeof system.args[4] != 'undefined' )
  pageOptions.margin.right = system.args[4];

if( typeof system.args[5] != 'undefined' )
  pageOptions.margin.bottom = system.args[5];

if( typeof system.args[6] != 'undefined' )
  pageOptions.margin.left = system.args[6];

page.paperSize = pageOptions;

// assume the file is local, so we don't handle status errors
page.open(system.args[1], function (status) {
  // export to target (can be PNG, JPG or PDF!)
  page.render(system.args[2]);
  phantom.exit();
});