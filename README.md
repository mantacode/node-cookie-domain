[![Build Status](https://travis-ci.org/mantacode/cookie-domain.svg?branch=master)](https://travis-ci.org/mantacode/node-cookie-domain)
[![NPM version](https://badge.fury.io/js/cookie-domain.svg)](http://badge.fury.io/js/cookie-domain)
[![David DM](https://david-dm.org/mantacode/cookie-domain.png)](https://david-dm.org/mantacode/cookie-domain.png)

Express middleware for dynamically setting the cookie domain.

```javascript
var express = require('express');
var cookieDomain = require('cookie-domain');
var app = express();
app.use(cookieDomain());
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
