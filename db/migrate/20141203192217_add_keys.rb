class AddKeys < ActiveRecord::Migration
  def change
    add_foreign_key "clients", "users", {name: "clients_user_id_fk", dependent: :delete}
    add_foreign_key "companies", "users", name: "companies_user_id_fk", dependent: :delete
    add_foreign_key "histories", "clients", name: "histories_client_id_fk", dependent: :delete
    add_foreign_key "histories", "users", name: "histories_user_id_fk", dependent: :delete
    add_foreign_key "invoices", "clients", name: "invoices_client_id_fk", dependent: :delete
    add_foreign_key "invoices", "users", name: "invoices_user_id_fk", dependent: :delete
    add_foreign_key "settings", "users", name: "settings_user_id_fk", dependent: :delete
    add_foreign_key "subscriptions", "plans", name: "subscriptions_plan_id_fk"
    add_foreign_key "subscriptions", "users", name: "subscriptions_user_id_fk", dependent: :delete
    add_foreign_key "vouchers", "users", name: "vouchers_redeemed_by_fk", column: "redeemed_by"
  end
end
