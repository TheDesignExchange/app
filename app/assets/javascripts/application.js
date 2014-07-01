// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
// require bootsy
//= require jquery.ui.autocomplete
//= require search
//= require validate
//= require expander
// require_tree .


// Fixing textarea bug
$(function(){
		$('textarea').unbind();
})


function DOM(){}
DOM.tag = function(t){
	return $("<"+ t +"/>");
}

function DE(){}
DE.cache = {};
DE.Autocomplete = {
	  source: function( request, response ) {
	    var term = request.term;
	    if ( term in DE.cache ) {
	      response( DE.cache[ term ] );
	      return;
	    }

	    $.getJSON( "/collection/autocomplete_design_methods", request, function( data, status, xhr ) {
	      DE.cache[ term ] = data;
	      response( data );
	    });
	  },
	  minLength: 1
}