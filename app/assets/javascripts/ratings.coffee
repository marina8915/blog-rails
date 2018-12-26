$(document).on 'turbolinks:load', ->
  stars = document.getElementsByClassName('br-widget')
  if stars.length == 0
    $('#rating').barrating theme: 'fontawesome-stars'
    return
