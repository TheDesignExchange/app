// Validates new design method form.
$(function() {
  var errors = new Array();
  $("#new_design_method").submit(function( event ) {
    if ($("#design_method_name").val() == "") {
      errors.push("Please name your method");
    }
    if ($("#design_method_overview").val() == "") {
      errors.push("Method must have an overview")
    }
    if (errors.length != 0) {
      for (i = 0; i < errors.length; i += 1) {
        var name = errors[i].match(/(name|overview)/);
        var span = "span#";
        span = span.concat(name);
        $(span).text(errors[i]).show();
      }
      alert("Mandatory fields were left empty.");
      event.preventDefault();
      errors = new Array();
    }
  })
});