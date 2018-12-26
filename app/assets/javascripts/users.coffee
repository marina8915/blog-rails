$(document).on 'turbolinks:load', ->
  # dialog in user session after 10 transitions
  views = document.getElementById('views').value
  if parseInt(views) == 10
    $('#dialog').modal()
  return
