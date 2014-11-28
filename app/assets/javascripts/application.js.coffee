#= require jquery
#= require jquery_ujs
#= require jquery-cookie
#= require bootstrap
#= require bootstrap-datetimepicker
#= require twitter/bootstrap/rails/confirm
#= require obfuscatejs
#= require jquery.autosize
#= require local_time
#= require turbolinks
#= require_tree .


$.fn.twitter_bootstrap_confirmbox.defaults.title = 'Paying Mantis'
Turbolinks.enableProgressBar()

showFlashMessages =  ->
  alert_types =
    notice: 'success'
    alert: 'error'
    info: 'info'
    warning: 'warning'
  cookieName = 'flash_messages'
  cookie = $.cookie(cookieName)
  if cookie?
    flashMessages = JSON.parse(cookie)
    for type, message of flashMessages
      $flash = $("<div class=\"alert alert-" + alert_types[type] + " fade in\"><button type=\"button\" class=\"close\" data-dismiss=\"alert\">&times;</button>" + message + "</div>")
      $('.messages').prepend($flash)
    $.removeCookie(cookieName, path: '/')

pageLoad = ->
  $('.carousel').carousel()
  $("[rel=tooltip]").tooltip()
  $("[rel=popover]").popover({html : true})
  $('textarea').autosize()
  $('.datepicker').datetimepicker({pickTime: false, autoclose: true}).on 'changeDate', (e) ->
     if $(this).data('datetimepicker').viewMode == 0
        $(this).datetimepicker('hide')
  showFlashMessages()


$(document).on 'page:load', pageLoad
$(document).on 'page:restore', pageLoad

$ -> pageLoad()

