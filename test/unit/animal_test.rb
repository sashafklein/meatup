# == Schema Information
#
# Table name: animals
#
#  id             :integer          not null, primary key
#  animal_type    :string(255)
#  name           :string(255)
#  breed          :string(255)
#  weight         :integer
#  photo          :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  ranch_id       :integer
#  butcher_id     :integer
#  cow_mult       :float
#  pig_mult       :float
#  lamb_mult      :float
#  goat_mult      :float
#  host_id        :integer
#  final_sale     :boolean          default(FALSE)
#  opening_sale   :boolean          default(TRUE)
#  open           :boolean          default(TRUE)
#  finalized      :boolean          default(FALSE)
#  hanging_weight :float
#  meat_weight    :float
#

require 'test_helper'

class AnimalTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
