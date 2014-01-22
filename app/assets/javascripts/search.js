$(function() {
  function split( val ) {
    return val.split( /,\s*/ );
  }

  function extractLast( term ) {
    return split( term ).pop();
  }

  $( "#query" )
    .bind( "keydown", function( event ) {
      if ( event.keyCode === $.ui.keyCode.TAB &&
        $( this ).data( "ui-autocomplete" ).menu.active ) {
      event.defaultPrevented();
    } })

    .autocomplete({
      source: function( request, response ) {
        $.getJSON( "/design_methods/autocomplete", {
                 term: extractLast( request.term )}, response );
      },

      focus: function() {
        return false;
      },

      select: function( event, ui ) {
        var terms = split( this.value );
        terms.pop();
        terms.push( ui.item.value );
        terms.push( "" );
        this.value = terms.join( ", " );
        return false;
        }
    });
});
