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
#= require bootstrap-wysihtml5
#= require jquery.ui.autocomplete
#= require search
#= require validate
#= require expander
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
  # WYSIWYG = "What You See Is What You Get" text editor
  editors = $('textarea.wysiwyg.form-control:visible');
  options =
    "font-styles": true #Font styling, e.g. h1, h2, etc. Default true
    "emphasis": true #Italics, bold, etc. Default true
    "lists": true #(Un)ordered lists, e.g. Bullets, Numbers. Default true. Neec to fix
    "html": false #Button which allows you to edit the generated HTML. Default false
    "link": true #Button to insert a link. Default true
    "image": true #Button to insert an image. Default true,
    "color": false #Button to change color of font
    "blockquote": true #Default true. Need to fix
  console.log options
  for elem in editors
    $(elem).wysihtml5({toolbar: options})
  return

updateSearchInput = (e) ->
  # After every search input, update the hidden query field in the filters form
  # so that submitting the filters form reflects the latest query value
  newSearchText = e.target.value
  $('input#hidden-search-input').val(newSearchText)
  return

$ ->
  activeTab = $('#tabs li.active').children('a').data('link')
  $('.tab-pane[data-link ="' + activeTab + '"]').show().siblings('.tab-pane').hide()
  $('.sidebar[data-link ="' + activeTab + '"]').show().siblings('.sidebar').hide()
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
  $('input#search-input').each( ->
    this.oninput = updateSearchInput
    return
  )
  initializeMarkdownEditors()
  return

$('a[data-popup]').live 'click', (e) ->
  window.open $(this).attr('href')
  e.preventDefault()
  return
