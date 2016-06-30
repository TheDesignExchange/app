# Validates new design method form.
$ ->
  errors = new Array

  errorChecker = (event) ->
    if $('#design_method_name').val() == ''
      errors.push '\nPlease name your method'
    if $('#design_method_overview').val() == ''
      errors.push '\nYour method must have a summary'
    if $('#design_method_process').val() == ''
      errors.push '\nYour method must have some instructions'
    if errors.length != 0
      i = 0
      while i < errors.length
        name = errors[i].match(/(name|overview)/)
        span = 'span#'
        span = span.concat(name)
        $(span).text(errors[i]).show()
        i += 1
      alert errors
      event.preventDefault()
      errors = new Array
    return

  $('#new_design_method').submit (event) ->
    errorChecker(event)
    return

  $('.edit_design_method').submit (event) ->
    errorChecker(event)
    return

  return
