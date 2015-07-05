# Validates new design method form.
$ ->
  errors = new Array
  $('#new_design_method').submit (event) ->
    if $('#design_method_name').val() == ''
      errors.push 'Please name your method'
    if $('#design_method_overview').val() == ''
      errors.push 'Method must have an overview'
    if errors.length != 0
      i = 0
      while i < errors.length
        name = errors[i].match(/(name|overview)/)
        span = 'span#'
        span = span.concat(name)
        $(span).text(errors[i]).show()
        i += 1
      alert 'Mandatory fields were left empty.'
      event.preventDefault()
      errors = new Array
    return
  return
