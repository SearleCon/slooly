class AddOnDeleteCascadeToForeignKeys < ActiveRecord::Migration
  def change

    remove_foreign_key :companies, :users
    add_foreign_key :companies, :users, on_delete: :cascade

    remove_foreign_key :settings, :users
    add_foreign_key :settings, :users, on_delete: :cascade

    remove_foreign_key :subscriptions, :users
    add_foreign_key :subscriptions, :users, on_delete: :cascade

    remove_foreign_key :vouchers, name: "vouchers_redeemed_by_fk"
    add_foreign_key :vouchers, :users, column: :redeemed_by, on_delete: :cascade

    remove_foreign_key :clients, :users
    add_foreign_key :clients, :users, on_delete: :cascade

    remove_foreign_key :invoices, :clients
    add_foreign_key :invoices, :clients, on_delete: :cascade


    remove_foreign_key :histories, :clients
    add_foreign_key :histories, :clients, on_delete: :cascade


    remove_foreign_key :invoices, :clients
    add_foreign_key :invoices, :clients, on_delete: :cascade


  end
end
