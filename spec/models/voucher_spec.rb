# == Schema Information
#
# Table name: vouchers
#
#  id             :integer          primary key
#  unique_code    :string(255)
#  redeemed_by    :integer
#  valid_until    :timestamp
#  number_of_days :integer
#  created_at     :timestamp        not null
#  updated_at     :timestamp        not null
#

require 'spec_helper'

describe Voucher do
  pending "add some examples to (or delete) #{__FILE__}"
end
