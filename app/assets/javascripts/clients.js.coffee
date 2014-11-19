$ ->
 $(document).on 'ajax:beforeSend', ->
   $('#progress-bar').show();
   $('.pagination-links').hide();
 $(document).on 'ajaxComplete', ->
   $('#progress-bar').hide();
   $('.pagination-links').show();

