/* DO NOT MODIFY. This file was compiled Mon, 10 Oct 2011 08:24:04 GMT from
 * /Users/Nima/Sites/OnTheRailsAgain/app/coffeescripts/article_show.coffee
 */

(function() {
  $(function() {
    return $(window).scroll(function() {
      var headers, i, summary_headers, _ref, _results;
      headers = $('.article_content > :header:not("h1")');
      summary_headers = $('#summary a');
      if ($(document).scrollTop() < 150) {
        summary_headers.css('font-weight', 'normal');
        return $(summary_headers[0]).css('font-weight', 'bold');
      } else if (($(document).scrollTop() + window.innerHeight) >= (document.body.scrollHeight - 20)) {
        summary_headers.css('font-weight', 'normal');
        return $(summary_headers[summary_headers.length - 1]).css('font-weight', 'bold');
      } else {
        _results = [];
        for (i = 0, _ref = headers.length; 0 <= _ref ? i <= _ref : i >= _ref; 0 <= _ref ? i++ : i--) {
          _results.push(i < headers.length && ($(headers[i]).offset().top - $(document).scrollTop()) < 15 ? (summary_headers.css('font-weight', 'normal'), $(summary_headers[i]).css('font-weight', 'bold')) : void 0);
        }
        return _results;
      }
    });
  });
}).call(this);
