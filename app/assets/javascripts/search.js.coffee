$ ->

  split = (val) ->
    val.split /,\s*/

  extractLast = (term) ->
    split(term).pop()

  $('#query').bind('keydown', (event) ->
    if event.keyCode == $.ui.keyCode.TAB and $(this).data('ui-autocomplete').menu.active
      event.defaultPrevented()
    return
  ).autocomplete
    source: (request, response) ->
      $.getJSON '/autocomplete', { term: extractLast(request.term) }, response
      return
    focus: ->
      false
    select: (event, ui) ->
      terms = split(@value)
      terms.pop()
      terms.push ui.item.value
      terms.push ''
      @value = terms.join(', ')
      false
  return
