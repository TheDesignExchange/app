# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# the compiled file.
#
# WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
# GO AFTER THE REQUIRES BELOW.
#
#= require jquery
#= require jquery_ujs
#= require jquery.tablesorter.combined.js
#= require jquery.tablesorter.widget-pager.js
#= require bootstrap
# require bootsy
#= require jquery.ui.autocomplete
#= require search
#= require validate
#= require expander
#= require meltdown/jquery.meltdown
# require_tree .
# Fixing textarea bug


removeTag = (id, self) ->
  console.log '/tags/' + id
  $.ajax
    url: '/tags/' + id
    type: 'DELETE'
  $(self).parent().remove()
  return

createTag = (model, model_id, tag, type) ->
  value = $(tag).parent().siblings('input').val()
  tag = {}
  tag[model + '_id'] = model_id
  tag['content'] = value
  tag['content_type'] = type
  # console.log(tag);
  $.ajax
    url: '/tags'
    type: 'POST'
    data:
      tag: tag
      commit: 'Create Tag'
    success: (html) ->
      console.log html
      $('.' + type + '-list').append html.tag
      return
    dataType: 'json'
  return

DOM = ->

window.DE = {}

removeMethodLink = (id, self) ->
  console.log '/method_case_studies/' + id
  $.ajax
    url: '/method_case_studies/' + id
    type: 'DELETE'
  $(self).parent().remove()
  return

createMethodLink = (case_study_id, method_case_study) ->
  value = $(method_case_study).parent().siblings('select').val()
  method_case_study = {}
  method_case_study['case_study_id'] = case_study_id
  method_case_study['design_method_id'] = value
  console.log method_case_study
  $.ajax
    url: '/method_case_studies'
    type: 'POST'
    data:
      method_case_study: method_case_study
      commit: 'Create Method Link'
    success: (html) ->
      console.log html
      $('.method-list').append html.mcs
      return
    dataType: 'json'
  return

$ ->
  $('textarea').unbind()
  return

DOM.tag = (t) ->
  $ '<' + t + '/>'

window.DE =
  cache: {}

  Autocomplete:
    source: (request, response) ->
      term = request.term
      if term in DE.cache
        response DE.cache[term]
        return
      $.getJSON '/autocomplete_search', request, (data, status, xhr) ->
        DE.cache[term] = data
        response data
        return
      return

    minLength: 1

initializeMarkdownEditors = () ->
  # The :visible selector is a bit of a hack, have to initialize hidden md
  # fields after they are shown, otherwise their width is screwed up and afaik
  # that cannot be reset without modifying the meltdown library
  $('textarea.markdown.form-control:visible')
    .meltdown(
      openPreview: true
      previewHeight: 'editorHeight'
      sidebyside: true
    )
    .removeClass("form-control")
  return

$ ->
  activeTab = $('#tabs li.active').children('a').data('link')
  $('.tab-pane[data-link ="' + activeTab + '"]').show().siblings('.tab-pane').hide()
  # TODO what is the point of this sidebar system???
  $('.sidebar[data-link ="' + 'all' + '"]').show().siblings('.sidebar').hide()
  $('#tabs li a').click (e) ->
    e.preventDefault()

    # Alternate tabs
    $(this).parent().addClass('active').siblings().removeClass 'active'
    link = $(this).data('link')

    # $('.tab-pane[data-link ~="'+ link +'"]').hide();
    $('.tab-pane[data-link ="' + link + '"]').show().siblings('.tab-pane').hide()
    $('.sidebar[data-link ="' + link + '"]').show().siblings('.sidebar').hide()

    # initialize any newly shown md editors
    initializeMarkdownEditors()
    return

  return

$(document).ready ($) ->
  initializeMarkdownEditors()
  return

$ ->
  $('.directUpload').find('input:file').each (i, elem) ->
    fileInput = $(elem)
    form = $(fileInput.parents('form:first'))
    submitButton = form.find('input[type="submit"]')
    progressBar = $('<div class=\'bar\'></div>')
    barContainer = $('<div class=\'progress\'></div>').append(progressBar)
    fileInput.after barContainer
    fileInput.fileupload
      fileInput: fileInput
      url: form.data('url')
      type: 'POST'
      autoUpload: true
      formData: form.data('form-data')
      paramName: 'file'
      dataType: 'XML'
      replaceFileInput: false
    return
  return


