#= require jquery
#= require jquery_ujs
#= require jquery-ui
#= require jquery-cookie
#= require jquery-validate
#= require bootstrap
#= require bootstrap-datetimepicker
#= require bootstrap-sortable
#= require twitter/bootstrap/rails/confirm
#= require obfuscatejs
#= require jquery.autosize
#= require jsTimezoneDetect
#= require local_time
#= require turbolinks
#= require_tree .

Turbolinks.enableProgressBar()
$.fn.twitter_bootstrap_confirmbox.defaults.title = 'Paying Mantis'

$.validator.setDefaults
  debug: true

  errorElement: 'span'

  errorPlacement: (error, element) ->
   error.appendTo( element.closest('div.controls'))


  highlight: (element) ->
    $(element).closest(".control-group").removeClass("success").addClass "error"
    return

  success: (element) ->
    $(element).closest(".control-group").removeClass("error").addClass "success"
    return

  errorClass: "help-block"


showFlashMessages = ->
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
      if alert_types.hasOwnProperty(type)
        $("<div>", { class: "alert alert-" + alert_types[type] + " fade in", text: message }).prepend(
          $("<button>", { class: 'close', type: 'button', 'data-dismiss': 'alert', text: 'x'})
        ).appendTo(".messages")
    $.removeCookie(cookieName, { path: '/' })

setTimeZone = ->
  tz = jstz.determine();
  $.cookie('timezone', tz.name(), { path: '/' });

pageLoad = ->
  $("form").each ->
    if $(this).data("validate")
      $(this).validate(
        submitHandler: (form)->
          form.submit()
      )

    return
  $('.carousel').carousel()
  $("[rel=tooltip]").tooltip()
  $("[rel=popover]").popover({html : true})
  $('textarea').autosize()
  $('.datepicker').datetimepicker({pickTime: false, autoclose: true}).on 'changeDate', (e) ->
     if $(this).data('datetimepicker').viewMode == 0
        $(this).datetimepicker('hide')
  $.bootstrapSortable(applyLast=true)
  showFlashMessages()
  setTimeZone()

$(document).on 'page:load', pageLoad
$(document).on 'page:restore', pageLoad

$ -> pageLoad()
