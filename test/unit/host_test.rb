# == Schema Information
#
# Table name: hosts
#
#  id         :integer          not null, primary key
#  address    :string(255)
#  city       :string(255)
#  state      :string(255)
#  phone      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class HostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
