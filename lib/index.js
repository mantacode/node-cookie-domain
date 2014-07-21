function middleware (options) {
  options = options || {};
  return function(req, res, next) {
    var parts = req.host.split('.');
    if (parts.length > 2) {
      parts[0] = '';
    }
    req.cookieDomain = parts.join('.');
    var defaults = {
      domain: req.cookieDomain,
      path: '/',
      maxAge: 31536000000
    };
    var _expressCookie = res.cookie;
    res.cookie = function(name, value, overrides) {
      if (overrides === false) _expressCookie(name, value);
      else {
        overrides = overrides || {};
        var cookieConfig = extend({}, defaults, options, overrides);
        cookieConfig = handleMaxAge(cookieConfig, overrides, options);
        _expressCookie(name, value, cookieConfig);
      }
    };
    next();
  };
}

function extend() {
  var args = [].slice.call(arguments).reverse();
  var dest = args.pop();
  for (var i = 0; i < args.length; i++) {
    var src = args[i];
    for (var k in src) {
      // Checking for undefined because some cookie values can be false (e.g. httpOnly)
      dest[k] = typeof dest[k] !== 'undefined' ? dest[k] : src[k];
    }
  }

  return dest;
}

function handleMaxAge(cookie, overrides, options) {
  // Express will prefer maxAge over expires, so having both is okay, unless the user is explicitly trying to override an existing maxAge with
  // expires. If the overrides contain expires, we want to use that instead of maxAge. If the global options contain expires, we want to use that
  // instead of maxAge, unless the overrides ALSO contain maxAge, in which case we want to use that. Note also that expires=false is significant.
  var hasExpires = typeof overrides.expires !== 'undefined' || (typeof options.expires !== 'undefined' && typeof overrides.maxAge === 'undefined');
  if (cookie.maxAge && cookie.expires && hasExpires) {
    delete cookie.maxAge;
  }
  return cookie;
}


middleware.version = require('./../package.json').version;
module.exports = middleware;
