# == Schema Information
#
# Table name: cuts
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  price          :float
#  percent        :float
#  package_weight :float
#  line_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  animal_type    :string(255)
#  comp           :float
#

require 'test_helper'

class CutTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
