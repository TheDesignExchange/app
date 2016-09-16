(function() {
  $(function() {
    var errorChecker, errors;
    errors = new Array;
    errorChecker = function(event) {
      var i, name, span;
      if ($('#design_method_name').val() === '') {
        errors.push('\nPlease name your method');
      }
      if ($('#design_method_overview').val() === '') {
        errors.push('\nYour method must have a summary');
      }
      if ($('#design_method_process').val() === '') {
        errors.push('\nYour method must have some instructions');
      }
      if (errors.length !== 0) {
        i = 0;
        while (i < errors.length) {
          name = errors[i].match(/(name|overview)/);
          span = 'span#';
          span = span.concat(name);
          $(span).text(errors[i]).show();
          i += 1;
        }
        alert(errors);
        event.preventDefault();
        errors = new Array;
      }
    };
    $('#new_design_method').submit(function(event) {
      errorChecker(event);
    });
    $('.edit_design_method').submit(function(event) {
      errorChecker(event);
    });
  });

}).call(this);
