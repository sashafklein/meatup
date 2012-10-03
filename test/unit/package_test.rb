# == Schema Information
#
# Table name: packages
#
#  id         :integer          not null, primary key
#  cut_id     :integer
#  original   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  animal_id  :integer
#  left       :integer
#  price      :decimal(, )
#

require 'test_helper'

class PackageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
