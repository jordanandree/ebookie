// html2pdf.js
var page = new WebPage();
var system = require("system");

// change the paper size to letter, add some borders
page.paperSize = {
  format: "Letter",
  orientation: "portrait",
  margin: {
    left:   "1.0in",
    right:  "1.0in",
    top:    "1.5in",
    bottom: "1.5in"
  }
};

// assume the file is local, so we don't handle status errors
page.open(system.args[1], function (status) {
  // export to target (can be PNG, JPG or PDF!)
  page.render(system.args[2]);
  phantom.exit();
});