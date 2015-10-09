#= require jquery
#= require jquery_ujs
#= require jquery-ui
#= require jquery-validate
#= require bootstrap
#= require bootstrap-datetimepicker
#= require bootstrap-sortable
#= require twitter/bootstrap/rails/confirm
#= require obfuscatejs
#= require jquery.autosize
#= require jquery.cookie
#= require jsTimezoneDetect
#= require local_time
#= require nprogress
#= require nprogress-turbolinks
#= require nprogress-ajax
#= require turbolinks
#= require_tree .

$.fn.twitter_bootstrap_confirmbox.defaults.title = 'Paying Mantis'

$.validator.setDefaults
  debug: true

  errorElement: 'span'

  onkeyup: false

  onfocusin: false

  onfocusout: (element) ->
    return $(element).valid()

  errorPlacement: (error, element) ->
   error.appendTo( $(element).closest('div.controls'))
   return

  highlight: (element) ->
    $(element).closest(".control-group").removeClass("success").addClass "error"
    return

  unhighlight: (element) ->
    $(element).closest(".control-group").removeClass("error")
    return

  errorClass: "help-block"

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
  setTimeZone()
  $(document).on 'ajax:success', '.announcement', ->
    $(this).closest('.alert').remove()

  $('input[id=upload-clients]').change ->
     $('#upload-clients-file').val($(this).val().split('\\').pop());


$(document).on 'page:load', pageLoad
$(document).on 'page:restore', pageLoad

$ -> pageLoad()

