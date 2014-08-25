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
//= require bootstrap
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

function removeTag(id, self){
	console.log("/tags/" + id);
	$.ajax({
	  url: "/tags/" + id,
	  type: "DELETE"
	});
	$(self).parent().remove();
}

function createTag(model, model_id, tag, type){
	var value = $(tag).parent().siblings('input').val();
	tag = {};
	tag[model + "_id"] = model_id;
	tag["content"] = value;
	tag["content_type"] = type;
	// console.log(tag);
	$.ajax({
	  url: "/tags",
	  type: "POST",
	  data: {tag: tag, commit:"Create Tag"},
	  success: function(html){
	  	console.log(html);
	  	$('.'+ type +'-list').append(html.tag);
	  },
	  dataType: "json"
	});
}

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
function removeMethodLink(id, self){
	console.log("/method_case_studies/" + id);
	$.ajax({
	  url: "/method_case_studies/" + id,
	  type: "DELETE"
	});
	$(self).parent().remove();
}

function createMethodLink(case_study_id, tag){
	var value = $(tag).parent().siblings('select').val();
	tag = {};
	tag["case_study_id"] = case_study_id;
	tag["design_method_id"] = value;
	console.log(tag);
	$.ajax({
	  url: "/method_case_studies",
	  type: "POST",
	  data: {tag: tag, commit:"Create Method Link"},
	  success: function(html){
	  	console.log(html);
	  	$('.method-list').append(html.mcs);
	  },
	  dataType: "json"
	});
}