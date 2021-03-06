#= require jquery
#= require jquery_ujs
#= require bootstrap
#= require bootstrap-datepicker
#= require bootstrap-filestyle
#= require local_time
#= require turbolinks

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
               <div class="modal" role="dialog">
                <div class="modal-dialog" role="document">
                 <div class="modal-content">
                   <div class="modal-header">
                     <a class="close" data-dismiss="modal">×</a>
                     <h4>Paying Mantis</h4>
                   </div>
                   <div class="modal-body">
                     <h5 class='text-danger'>WARNING!</h5>
                     #{message}
                   </div>
                   <div class="modal-footer">
                     <a data-dismiss="modal" class="btn btn-default">Cancel</a>
                   </div>
                  </div>
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


$(document).on "turbolinks:load", ->

  $('[data-toggle="tooltip"]').tooltip();
  $('.datepicker').datepicker(
    autoclose: true
    format: 'dd MM yyyy'
    orientation: 'bottom'
  ).on 'change', ->
     $(this).valid();

  $(":file").filestyle({buttonName: 'btn-info'});
