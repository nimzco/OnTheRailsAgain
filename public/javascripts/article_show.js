/* DO NOT MODIFY. This file was compiled Tue, 09 Aug 2011 19:45:55 GMT from
 * /Users/Nima/Sites/OnTheRailsAgain/app/coffeescripts/article_show.coffee
 */

(function() {
  $(function() {
    return $(window).scroll(function() {
      var headers, i, summary_headers, _ref, _results;
      headers = $('.article_content :header');
      summary_headers = $('#summary a');
      _results = [];
      for (i = 0, _ref = headers.length - 1; 0 <= _ref ? i <= _ref : i >= _ref; 0 <= _ref ? i++ : i--) {
        _results.push(($(headers[i]).offset().top - $(document).scrollTop()) < 80 ? (summary_headers.removeClass('current_content'), $(summary_headers[i]).addClass('current_content')) : void 0);
      }
      return _results;
    });
  });
}).call(this);
