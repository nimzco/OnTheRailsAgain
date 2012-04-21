$( ->
  $('#summary_content').localScroll {duration: 350}
  $('#summary_content').scrollspy()

  see_also_div         = $('#see-also')
  see_also_width       = $('#see-also').width()
  see_also_initial_right_position = $('#see-also').css('right')
  last_header_position = $('.article_content > :header:not("h1")').last().offset().top
  
  # When the user is reading the last part
  if ($(document).scrollTop() + window.innerHeight) > last_header_position
    if see_also_div.hasClass('bounceOutRight')
      see_also_div.removeClass('bounceOutRight animated').addClass('bounceInRight animated')
  else if see_also_div.hasClass('bounceInRight')
    see_also_div.removeClass('bounceInRight animated').addClass('bounceOutRight animated')

  sidePanel = $("#summary > div")

  if sidePanel.length > 0
    sidebarTop = sidePanel.offset().top
    first = true
    $(document).scroll((evt) ->
        if (first)
          sidebarTop = sidePanel.offset().top;
          first = false;
        wTop = $(window).scrollTop();
        if (wTop > sidebarTop)
          sidePanel.css({
              position: "fixed",
              top: "0px",
          });
        else
          sidePanel.css({
              position: "static"
          });
    );
)
