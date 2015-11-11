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
#= require bootstrap
# require bootsy
#= require jquery.ui.autocomplete
#= require search
#= require validate
#= require expander
#= require meltdown/jquery.meltdown
#= require react/react.js
#= require react/react-dom.js
#= require react/babel-core-browser.min.js
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


$ ->
  $('.tab-pane[data-link ="'+ "all" +'"]').show().siblings(".tab-pane").hide();
  $('.sidebar[data-link ="' + 'all' + '"]').show().siblings('.sidebar').hide()
  $('#tabs li a').click (e) ->
    e.preventDefault()
    # Alternate tabs
    $(this).parent().addClass('active').siblings().removeClass 'active'
    link = $(this).data('link')
    # $('.tab-pane[data-link ~="'+ link +'"]').hide();
    $('.tab-pane[data-link ="' + link + '"]').show().siblings('.tab-pane').hide()
    $('.sidebar[data-link ="' + link + '"]').show().siblings('.sidebar').hide()
    return
  return

$(document).ready ($) ->
  $('textarea.markdown')
    .meltdown(
      openPreview: true
      previewHeight: 'auto'
      sidebyside: true
    )
    .removeClass("form-control")
  return