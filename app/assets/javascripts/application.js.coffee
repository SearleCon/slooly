#= require jquery
#= require jquery_ujs
#= require jquery-validate
#= require bootstrap
#= require bootstrap-datetimepicker
#= require obfuscatejs
#= require jquery.autosize
#= require jquery.cookie
#= require jsTimezoneDetect
#= require nprogress
#= require nprogress-turbolinks
#= require nprogress-ajax
#= require turbolinks
#= require_tree .

$.rails.allowAction = (element) ->
  # The message is something like "Are you sure?"
  message = element.data('confirm')
  # If there's no message, there's no data-confirm attribute,
  # which means there's nothing to confirm
  return true unless message
  # Clone the clicked element (probably a delete link) so we can use it in the dialog box.
  $link = element.clone()
  # We don't necessarily want the same styling as the original link/button.
  .removeAttr('class')
  # We don't want to pop up another confirmation (recursion)
  .removeAttr('data-confirm')
  # We want a button
  .addClass('btn').addClass('btn-danger')
  # We want it to sound confirmy
  .html("Ok")

  # Create the modal box with the message
  modal_html = """
               <div class="modal" id="myModal">
                 <div class="modal-header">
                   <a class="close" data-dismiss="modal">×</a>
                   <h4>Paying Mantis</h4>
                 </div>
                 <div class="modal-body">
                   <p>#{message}</p>
                 </div>
                 <div class="modal-footer">
                   <a data-dismiss="modal" class="btn">Cancel</a>
                 </div>
               </div>
               """
  $modal_html = $(modal_html)
  # Add the new button to the modal box
  $modal_html.find('.modal-footer').append($link)
  # Pop it up
  $modal_html.modal()
  # Prevent the original link from working
  return false


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


  setTimeZone()
  $(document).on 'ajax:success', '.announcement', ->
    $(this).closest('.alert').remove()

  $('input[id=upload-clients]').change ->
     $('#upload-clients-file').val($(this).val().split('\\').pop());


$(document).on 'page:load', pageLoad
$(document).on 'page:restore', pageLoad

$ -> pageLoad()

