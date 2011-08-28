/* DO NOT MODIFY. This file was compiled Sun, 28 Aug 2011 20:01:46 GMT from
 * /Users/Nima/Sites/OnTheRailsAgain/app/coffeescripts/article_show.coffee
 */

(function() {
  $(function() {
    return $(window).scroll(function() {
      var headers, i, summary_headers, _ref, _results;
      headers = $('.article_content > :header');
      summary_headers = $('#summary a');
      _results = [];
      for (i = 0, _ref = headers.length - 1; 0 <= _ref ? i <= _ref : i >= _ref; 0 <= _ref ? i++ : i--) {
        _results.push(i < headers.length - 1 && ($(headers[i + 1]).offset().top - $(document).scrollTop()) < 15 ? (summary_headers.css('font-weight', 'normal'), $(summary_headers[i]).css('font-weight', 'bold')) : void 0);
      }
      return _results;
    });
  });
}).call(this);
