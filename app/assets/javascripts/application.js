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
//= require jquery.purr
//= require best_in_place
//= require bootstrap-datepicker
//= require_tree .


$(document).ready(function() {
	$('.carousel').carousel()
    $("[rel=tooltip]").tooltip(); // this will trigger a tooltip on all that have rel="tooltip" elements
    $("[rel=popover]").popover(); // this will trigger a POPOVER on all that have rel="popover" elements	
});

$(document).on("focus", "[databehaviour~='datepicker']", function(e){
    $(this).datepicker({"format": "yyyy-mm-dd", "weekStart": 1, "autoclose": true});
});

// The next 3 paragraphs are for the confirm delete modal box. It works well. START
$.rails.allowAction = function(link) {
    if (!link.attr('data-confirm')) {
        return true;
    }
    $.rails.showConfirmDialog(link);
    return false;
};

$.rails.confirmed = function(link) {
    link.removeAttr('data-confirm');
    return link.trigger('click.rails');
};


$.rails.showConfirmDialog = function(link) {
    var html, message;
    message = link.attr('data-confirm');
    html = "<div class=\"modal\" id=\"confirmationDialog\">\n  <div class=\"modal-header\">\n    <a class=\"close\" data-dismiss=\"modal\">X</a>\n    <h3>Confirm delete</h3>\n  </div>\n  <div class=\"modal-body\">\n    " + message + "\n  </div>\n  <div class=\"modal-footer\">\n    <a data-dismiss=\"modal\" class=\"btn\">Cancel</a>\n    <a data-dismiss=\"modal\" class=\"btn btn-primary confirm\">OK</a>\n  </div>\n</div>";
    $(html).modal();
    return $('#confirmationDialog .confirm').on('click', function() {
        return $.rails.confirmed(link);
    });
};
// The above 3 paragraphs are for the confirm delete modal box. It works well. END
