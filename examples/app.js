var express = require('express');
var app = express();
var cookieDomain = require('cookie-domain');

app.use(cookieDomain());

app.get('/', function(req, res, next) {
  res.cookie('defaults', 1);
  res.send('Successfully set cookie using default cookie options.');
});

app.get('/override', function(req, res, next) {
  res.cookie('override', 1, { maxAge: 86400 }) // one day
  res.send('Successfully set cookie by extending defaults with overrides.');
});

app.get('/options', cookieDomain({ expires: false }), function(req, res, next) {
  res.cookie('global options', 1);
  res.send('Successfully set cookie by extending defaults with global options passed into middleware.');
});

require('http').Server(app).listen(process.env.PORT || 3000);
