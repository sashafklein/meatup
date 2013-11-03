# == Schema Information
#
# Table name: ranch_animals
#
#  id            :integer          not null, primary key
#  animal_type   :string(255)
#  meat_price    :float
#  hanging_price :float
#  live_price    :float
#  fixed_cost    :float            default(0.0)
#  ranch_id      :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_helper'

describe RanchAnimal do
  pending "add some examples to (or delete) #{__FILE__}"
end
