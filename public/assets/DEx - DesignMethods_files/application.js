(function() {
  var DOM, createMethodLink, createTag, initializeMarkdownEditors, removeMethodLink, removeTag, updateSearchInput,
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  removeTag = function(id, self) {
    console.log('/tags/' + id);
    $.ajax({
      url: '/tags/' + id,
      type: 'DELETE'
    });
    $(self).parent().remove();
  };

  createTag = function(model, model_id, tag, type) {
    var value;
    value = $(tag).parent().siblings('input').val();
    tag = {};
    tag[model + '_id'] = model_id;
    tag['content'] = value;
    tag['content_type'] = type;
    $.ajax({
      url: '/tags',
      type: 'POST',
      data: {
        tag: tag,
        commit: 'Create Tag'
      },
      success: function(html) {
        console.log(html);
        $('.' + type + '-list').append(html.tag);
      },
      dataType: 'json'
    });
  };

  DOM = function() {};

  window.DE = {};

  removeMethodLink = function(id, self) {
    console.log('/method_case_studies/' + id);
    $.ajax({
      url: '/method_case_studies/' + id,
      type: 'DELETE'
    });
    $(self).parent().remove();
  };

  createMethodLink = function(case_study_id, method_case_study) {
    var value;
    value = $(method_case_study).parent().siblings('select').val();
    method_case_study = {};
    method_case_study['case_study_id'] = case_study_id;
    method_case_study['design_method_id'] = value;
    console.log(method_case_study);
    $.ajax({
      url: '/method_case_studies',
      type: 'POST',
      data: {
        method_case_study: method_case_study,
        commit: 'Create Method Link'
      },
      success: function(html) {
        console.log(html);
        $('.method-list').append(html.mcs);
      },
      dataType: 'json'
    });
  };

  $(function() {
    $('textarea').unbind();
  });

  DOM.tag = function(t) {
    return $('<' + t + '/>');
  };

  window.DE = {
    cache: {},
    Autocomplete: {
      source: function(request, response) {
        var term;
        term = request.term;
        if (__indexOf.call(DE.cache, term) >= 0) {
          response(DE.cache[term]);
          return;
        }
        $.getJSON('/autocomplete_search', request, function(data, status, xhr) {
          DE.cache[term] = data;
          response(data);
        });
      },
      minLength: 1
    }
  };

  initializeMarkdownEditors = function() {
    $('textarea.markdown.form-control:visible').meltdown({
      openPreview: true,
      previewHeight: 'editorHeight',
      sidebyside: true
    }).removeClass("form-control");
  };

  updateSearchInput = function(e) {
    var newSearchText;
    newSearchText = e.target.value;
    $('input#hidden-search-input').val(newSearchText);
  };

  $(function() {
    var activeTab;
    activeTab = $('#tabs li.active').children('a').data('link');
    $('.tab-pane[data-link ="' + activeTab + '"]').show().siblings('.tab-pane').hide();
    $('.sidebar[data-link ="' + activeTab + '"]').show().siblings('.sidebar').hide();
    $('#tabs li a').click(function(e) {
      var link;
      e.preventDefault();
      $(this).parent().addClass('active').siblings().removeClass('active');
      link = $(this).data('link');
      $('.tab-pane[data-link ="' + link + '"]').show().siblings('.tab-pane').hide();
      $('.sidebar[data-link ="' + link + '"]').show().siblings('.sidebar').hide();
      initializeMarkdownEditors();
    });
  });

  $(document).ready(function($) {
    $('input#search-input').each(function() {
      this.oninput = updateSearchInput;
    });
    initializeMarkdownEditors();
  });

}).call(this);
