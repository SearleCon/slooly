module ClientsHelper

  def confirm_delete_client_message(client)
    simple_format("<span class='label label-important'>WARNING!</span><br>
                   You are about to delete the client <b> #{client.business_name}!</b><br>
                   <b>NOTE:</b> All related invoices will also be deleted! This cannot be undone!<br>
                   Are you sure you want to continue?", {}, sanitize: false)
  end
end