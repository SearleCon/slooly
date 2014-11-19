# == Schema Information
#
# Table name: roles
#
#  id            :integer          primary key
#  name          :string(255)
#  resource_id   :integer
#  resource_type :string(255)
#  created_at    :timestamp        not null
#  updated_at    :timestamp        not null
#

class Role < ActiveRecord::Base
  has_and_belongs_to_many :users, join_table: :users_roles
  belongs_to :resource, polymorphic: true

  scopify
end
