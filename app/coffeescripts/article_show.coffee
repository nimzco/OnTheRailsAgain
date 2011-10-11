$( ->
  $(window).scroll( ->
    headers         = $('.article_content > :header:not("h1")')
    summary_headers = $('#summary a')
    # If at the begining of the document
    if $(document).scrollTop() < 150
      summary_headers.css('font-weight', 'normal')
      $(summary_headers[0]).css('font-weight', 'bold')      

    # If reach the end of the page, select last header
    else if ($(document).scrollTop() + window.innerHeight) >= (document.body.scrollHeight - 20)
      summary_headers.css('font-weight', 'normal')
      $(summary_headers[summary_headers.length - 1]).css('font-weight', 'bold')

    # Else check which header to select
    else
      for i in [0..(headers.length)]
        if i < headers.length and ($(headers[i]).offset().top - $(document).scrollTop()) < 15
          summary_headers.css('font-weight', 'normal')
          $(summary_headers[i]).css('font-weight', 'bold')    
  )

)
