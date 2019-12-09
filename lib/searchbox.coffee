# Handle input events from the search box. There is machinery
# here that anticipates incremental search that is yet to be coded.
# We use dependency injection to break dependency loops.

createSearch = require './search'

search = null

inject = (neighborhood) ->
  search = createSearch({neighborhood})

bind = ->
  $('.search').attr('autocomplete', 'off')
  $('input.search').on 'keypress', (e)->
    if e.keyCode == 27
      $('.incremental-search').remove()
    return if e.keyCode != 13 # 13 == return
    searchQuery = $(this).val()
    search.performSearch( searchQuery )
    $(this).val("")

  $('input.search').on 'input', (e)->
    searchQuery = $(this).val()
    search.incrementalSearch( searchQuery )
  $('input.search').blur (e)->
    $('.incremental-search').remove()

module.exports = {inject, bind}
