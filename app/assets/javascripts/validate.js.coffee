# Validates new design method form.
$ ->
  errors = new Array
  $('#new_design_method').submit (event) ->
    if $('#design_method_name').val() == ''
      errors.push '\nPlease name your method'
    if $('#design_method_overview').val() == ''
      errors.push '\nMethod must have an overview'
    if $('#design_method_process').val() == ''
      errors.push '\nMethod must have process'
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
  return
