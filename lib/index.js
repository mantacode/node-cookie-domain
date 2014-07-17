function middleware (options) {
  options = options || {};
  return function(req, res, next) {
    var parts = req.get('host').split(':')[0].split('.');
    if (parts.length > 2) {
      parts[0] = '';
    }
    req.cookieDomain = parts.join('.');
    next();
  };
}

middleware.version = require('./../package.json').version;
module.exports = middleware;
