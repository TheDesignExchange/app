#orig code from here: http://www.impressivewebs.com/textarea-auto-resize/
$ ->
  txt = $('textarea')
  hiddenDiv = $(document.createElement('div'))
  content = null
  #removes scrolling only when javascript is enabled.
  txt.addClass 'noscroll'
  hiddenDiv.addClass 'hiddendiv common'
  $('body').append hiddenDiv
  txt.on 'keyup click mouseenter', ->
    content = $(this).val()
    content = content.replace(/\n/g, '<br>')
    hiddenDiv.html content + '<br class="lbr">'
    $(this).css 'height', hiddenDiv.height()
    return
  return
