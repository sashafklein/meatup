# == Schema Information
#
# Table name: butchers
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  address       :string(255)
#  hanging_price :decimal(, )
#  final_price   :decimal(, )
#  vacuum_price  :decimal(, )
#  wrap_price    :decimal(, )
#  phone         :string(255)
#  user_id       :integer
#  ground        :boolean
#  stew          :boolean
#  boneless      :boolean
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  state         :string(255)
#  zip           :string(255)
#  city          :string(255)
#

require 'test_helper'

class ButcherTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
