# == Schema Information
#
# Table name: animals
#
#  id          :integer          not null, primary key
#  animal_type :string(255)
#  name        :string(255)
#  breed       :string(255)
#  weight      :integer
#  farm        :string(255)
#  host        :string(255)
#  photo       :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  ranch_id    :integer
#  butcher_id  :integer
#  cow_mult    :decimal(, )
#  pig_mult    :decimal(, )
#  lamb_mult   :decimal(, )
#  goat_mult   :decimal(, )
#

require 'test_helper'

class AnimalTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
