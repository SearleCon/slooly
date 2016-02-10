$.validator.setDefaults
  debug: true

  errorElement: 'span'

  onkeyup: false

  onfocusin: false

  onfocusout: (element) ->
    return $(element).valid()

  errorPlacement: (error, element) ->
   error.appendTo( $(element).closest('.form-group'))
   return

  highlight: (element) ->
    $(element).closest(".form-group").removeClass("has-success").addClass "has-error"
    return

  unhighlight: (element) ->
    $(element).closest(".form-group").removeClass("has-error")
    return

  errorClass: "help-block"


$(document).on "page:change", ->
  $("form").each ->
    if $(this).data("validate")
      $(this).validate(
        submitHandler: (form)->
          if $(form).data('remote')
            $.rails.handleRemote($(form))
          else
            form.submit()
      )

    return
