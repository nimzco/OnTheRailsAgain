$( ->
  $(window).scroll( ->
    headers         = $('.article_content :header')
    summary_headers = $('#summary a')
    for i in [0..(headers.length - 1)]
      if ($(headers[i]).offset().top - $(document).scrollTop()) < 80
        summary_headers.removeClass('current_content')
        $(summary_headers[i]).addClass('current_content')
  )

)
