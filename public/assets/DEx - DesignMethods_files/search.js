(function() {
  $(function() {
    var extractLast, split;
    split = function(val) {
      return val.split(/,\s*/);
    };
    extractLast = function(term) {
      return split(term).pop();
    };
    $('#query').bind('keydown', function(event) {
      if (event.keyCode === $.ui.keyCode.TAB && $(this).data('ui-autocomplete').menu.active) {
        event.defaultPrevented();
      }
    }).autocomplete({
      source: function(request, response) {
        $.getJSON('/autocomplete', {
          term: extractLast(request.term)
        }, response);
      },
      focus: function() {
        return false;
      },
      select: function(event, ui) {
        var terms;
        terms = split(this.value);
        terms.pop();
        terms.push(ui.item.value);
        terms.push('');
        this.value = terms.join(', ');
        return false;
      }
    });
  });

}).call(this);
