$( ->
  # Get all headers of the article except the title (h1)
  headers              = $('.article_content > :header:not("h1")')
  # Get all headers of the summary
  summary_headers      = $('#summary a')
  last_header_position = $('.article_content > :header:not("h1")').last().offset().top
  see_also_div         = $('#see-also')
  see_also_width       = $('#see-also').width()
  see_also_initial_right_position = $('#see-also').css('right')
  console.log see_also_initial_right_position
  # Will select the current header in the summary regarding the position of the window
  $(window).scroll( ->    
    # Select the first header if the window is on top of the page
    if $(document).scrollTop() < 150
      summary_headers.css('font-weight', 'normal')
      $(summary_headers[0]).css('font-weight', 'bold')      

    # Select the last header if the window is at the bottom of the page
    else if ($(document).scrollTop() + window.innerHeight) >= (document.body.scrollHeight - 20)
      summary_headers.css('font-weight', 'normal')
      $(summary_headers[summary_headers.length - 1]).css('font-weight', 'bold')

    # Else check which header to select
    else
      for i in [0..(headers.length)]
        if i < headers.length and ($(headers[i]).offset().top - $(document).scrollTop()) < (window.innerHeight / 3)
          summary_headers.css('font-weight', 'normal')
          $(summary_headers[i]).css('font-weight', 'bold')

    # When the user is reading the last part
    if ($(document).scrollTop() + window.innerHeight) > last_header_position
      if see_also_div.css('right') == see_also_initial_right_position
        see_also_div.animate({'right': '-10px'}, {queue: false})
    else if see_also_div.css('right') == '-10px'
      see_also_div.animate({'right': '-1000px'}, {queue: false})

  )
  
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
