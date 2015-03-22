var system = require('system');
var page = require('webpage').create();
var tableID = system.args[2];
page.open(system.args[1], function() {
  var rv = page.evaluate(function(tableID) {
    function strim(str) { return str.replace(/(\r\n|\n|\r|\t)/gm," ").replace(/\s+/g," "); }
    var tb = document.getElementById(tableID).firstElementChild;
    var hr = tb.firstElementChild;
    var headers = [];
    for (var i = 0; i < hr.childElementCount; i++) {
      headers.push(strim(hr.children[i].textContent));
    }
    headers[0] = 'Details';

    var rows = [];
    for (var tr = hr.nextSibling; tr; tr = tr.nextSibling) {
      var rowData = {};
      for (var i = 0; i < tr.childElementCount; i++) {
        if (i == 0) {
          rowData[headers[i]] = tr.children[i].getElementsByTagName('a')[0].getAttribute("href");
        } else {
          rowData[headers[i]] = strim(tr.children[i].textContent);
        }
      }
      rows.push(rowData);
    }
    return rows;
  }, tableID);
  console.log(JSON.stringify(rv, null, 2));
  phantom.exit();
});
