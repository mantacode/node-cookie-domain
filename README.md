[![Build Status](https://travis-ci.org/mantacode/node-cookie-domain.svg?branch=master)](https://travis-ci.org/mantacode/node-cookie-domain)
[![NPM version](https://badge.fury.io/js/cookie-domain.svg)](http://badge.fury.io/js/cookie-domain)
[![David DM](https://david-dm.org/mantacode/node-cookie-domain.png)](https://david-dm.org/mantacode/node-cookie-domain.png)

Express middleware for wrapping res.cookie to use some sane defaults for the cookie config.

```javascript
// Assuming the host is 'foo.bar.com'
var express = require('express');
var cookieDomain = require('cookie-domain');
var app = express();
app.use(cookieDomain());

/*
 *  You can also pass global overrides into cookieDomain
 *  app.use(cookieDomain({ maxAge: 86400 });
 */

app.get('/', function(req, res, next) {
  // Set a cookie using some sane defaults: { domain: '.bar.com', path: '/', maxAge: 31536000000 })
  res.cookie('a', 1);

  // Or override the defaults
  res.cookie('b', 1, { maxAge: 86400 });

  // Express will use maxAge over expires, but cookie-domain will remove maxAge and pass expires if you tell it to
  res.cookie('c', 1, { expires: false });

  // Pass false to tell cookie-domain not to pass options at all.
  res.cookie('d', 1, false);

  res.send('hello world');
});
```

# Installation and Environment Setup

Install node.js (See download and install instructions here: http://nodejs.org/).

Clone this repository

    > git clone git@github.com:mantacode/node-cookie-domain.git

cd into the directory and install the dependencies

    > cd cookie-domain
    > npm install && npm shrinkwrap --dev

# Running Tests

Install coffee-script

    > npm install coffee-script -g

Tests are run using grunt.  You must first globally install the grunt-cli with npm.

    > sudo npm install -g grunt-cli

## Unit Tests

To run the tests, just run grunt

    > grunt spec
