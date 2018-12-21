$(document).on 'turbolinks:load', ->
  spans = document.getElementsByTagName('span')
  if spans.length == 0
    $('.flp label').each ->
      sop = '<span class="ch">'
      #span opening
      scl = '</span>'
      $(this).html sop + $(this).html().split('').join(scl + sop) + scl
      #to prevent space-only spans from collapsing
      $('.ch:contains(\' \')').html '&nbsp;'
      return
    d = undefined

  $('.flp input').focus ->
    `var tm`
    #calculate movement for .ch = half of input height
    tm = $(this).outerHeight() / 2 * -1 + 'px'
    #label = next sibling of input
    #to prevent multiple animation trigger by mistake we will use .stop() before animating any character and clear any animation queued by .delay()
    $(this).next().addClass('focussed').children().stop(true).each (i) ->
      d = i * 50
      #delay
      $(this).delay(d).animate { top: tm }, 200, 'easeOutBack'
      return
    return
  $('.flp input').blur ->
#animate the label down if content of the input is empty
    if $(this).val() == ''
      $(this).next().removeClass('focussed').children().stop(true).each (i) ->
        d = i * 50
        $(this).delay(d).animate { top: 0 }, 500, 'easeInOutBack'
        return
    return
  return
