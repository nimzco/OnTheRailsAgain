$( ->
  $(window).scroll( ->
    headers         = $('.article_content > :header')
    summary_headers = $('#summary a')

    for i in [0..(headers.length - 1)]
      
      if i < headers.length - 1 and ($(headers[i + 1]).offset().top - $(document).scrollTop()) < 15
        # summary_headers.removeClass('current_content')
        # $(summary_headers[i]).addClass('current_content')
        summary_headers.css('font-weight', 'normal')
        $(summary_headers[i]).css('font-weight', 'bold')
    
  )

)
