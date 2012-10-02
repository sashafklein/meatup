# == Schema Information
#
# Table name: ranches
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  address      :string(255)
#  phone        :string(255)
#  user_id      :integer
#  cow          :boolean
#  pig          :boolean
#  lamb         :boolean
#  goat         :boolean
#  cow_live     :decimal(, )
#  pig_live     :decimal(, )
#  goat_live    :decimal(, )
#  lamb_live    :decimal(, )
#  cow_carcass  :decimal(, )
#  pig_carcass  :decimal(, )
#  lamb_carcass :decimal(, )
#  goat_carcass :decimal(, )
#  cow_hanging  :decimal(, )
#  pig_hanging  :decimal(, )
#  lamb_hanging :decimal(, )
#  goat_hanging :decimal(, )
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class RanchTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
