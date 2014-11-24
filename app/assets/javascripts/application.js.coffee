#= require jquery
#= require jquery_ujs
#= require bootstrap
#= require bootstrap-datetimepicker
#= require twitter/bootstrap/rails/confirm
#= require obfuscatejs
#= require jquery.autosize
#= require local_time
#= require turbolinks
#= require_tree .


$.fn.twitter_bootstrap_confirmbox.defaults.title = 'Paying Mantis'
Turbolinks.enableProgressBar();

pageLoad = ->
  $('.carousel').carousel()
  $("[rel=tooltip]").tooltip()
  $("[rel=popover]").popover()
  $('textarea').autosize()
  $('.datepicker').datetimepicker({pickTime: false, autoclose: true}).on 'changeDate', (e) ->
     if $(this).data('datetimepicker').viewMode == 0
        $(this).datetimepicker('hide')


$(document).on 'page:load', pageLoad
$(document).on 'page:restore', pageLoad

$ -> pageLoad()

