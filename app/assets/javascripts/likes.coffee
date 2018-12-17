$(document).on 'turbolinks:load', ->
  $('.likes').hover (->
    $('.info', this).show()
    $('.result', this).hide()
    return
  ), ->
    $('.info', this).hide()
    $('.result', this).show()
    return
  return
