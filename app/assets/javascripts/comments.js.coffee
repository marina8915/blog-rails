# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on '[data-behavior=~show_more]', (event) ->
  $pager = $(event.currentTarget)
  currentPage = $pager.data('currentPage') || 0
  nextPage = currentPage + 1

  $get "/comments?page=#{nextPage}"
  $pager.data 'currentPage', nextPage
