var express = require('express');
var app = express();
var cookieDomain = require('cookie-domain');

app.use(cookieDomain());

app.get('/', function(req, res, next) {
  console.log(req.cookieDomain);
  console.log(req.get('host'));
  res.cookie('visited', 1, { domain: req.cookieDomain, path: '/', expires: false });
  res.send('Hello world');
});

require('http').Server(app).listen(process.env.PORT || 3000);
