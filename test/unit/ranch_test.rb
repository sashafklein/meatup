# == Schema Information
#
# Table name: ranches
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  address           :string(255)
#  phone             :string(255)
#  user_id           :integer
#  cow               :boolean          default(FALSE)
#  pig               :boolean          default(FALSE)
#  lamb              :boolean          default(FALSE)
#  goat              :boolean          default(FALSE)
#  cow_live          :float
#  pig_live          :float
#  goat_live         :float
#  lamb_live         :float
#  cow_meat          :float
#  pig_meat          :float
#  lamb_meat         :float
#  goat_meat         :float
#  cow_hanging       :float
#  pig_hanging       :float
#  lamb_hanging      :float
#  goat_hanging      :float
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  state             :string(255)
#  zip               :string(255)
#  city              :string(255)
#  preferred_butcher :integer
#  has_csa           :boolean          default(FALSE)
#  delivers_butcher  :boolean          default(FALSE)
#  delivers_drop     :boolean          default(FALSE)
#  delivers_host     :boolean          default(FALSE)
#  cow_fixed         :integer          default(0)
#  pig_fixed         :integer          default(0)
#  lamb_fixed        :integer          default(0)
#  goat_fixed        :integer          default(0)
#

require 'test_helper'

class RanchTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
