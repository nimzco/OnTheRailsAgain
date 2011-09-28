/* DO NOT MODIFY. This file was compiled Wed, 28 Sep 2011 13:45:40 GMT from
 * /Users/Nima/Sites/OnTheRailsAgain/app/coffeescripts/article_show.coffee
 */

(function() {
  $(function() {
    return $(window).scroll(function() {
      var headers, i, summary_headers, _ref, _ref2, _results;
      headers = $('.article_content > :header:not("h1")');
      summary_headers = $('#summary a');
      if ((0 < (_ref = $(document).scrollTop()) && _ref < 50)) {
        summary_headers.css('font-weight', 'normal');
        return $(summary_headers[0]).css('font-weight', 'bold');
      } else if ($(document).scrollTop() + window.innerHeight >= document.body.scrollHeight) {
        summary_headers.css('font-weight', 'normal');
        return $(summary_headers[summary_headers.length - 1]).css('font-weight', 'bold');
      } else {
        _results = [];
        for (i = 0, _ref2 = headers.length; 0 <= _ref2 ? i <= _ref2 : i >= _ref2; 0 <= _ref2 ? i++ : i--) {
          _results.push(i < headers.length && ($(headers[i]).offset().top - $(document).scrollTop()) < 15 ? (summary_headers.css('font-weight', 'normal'), $(summary_headers[i]).css('font-weight', 'bold')) : void 0);
        }
        return _results;
      }
    });
  });
}).call(this);
