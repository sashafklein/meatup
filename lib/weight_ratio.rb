class WeightRatio

  def initialize(animal_type)
    @animal = animal_type.downcase.capitalize
  end

  def animal
    @animal
  end

  def ratio(top, bottom)
    top, bottom = prep(top), prep(bottom) 
    "WeightRatio::#{animal}#{top}Over#{bottom}".constantize
  end

  def prep(input)
    input.to_s.downcase.capitalize
  end

  # The Ratio Constants -- called above
  CowMeatOverHanging = 0.701
  CowHangingOverMeat = 1 / CowMeatOverHanging
  CowMeatOverLive = 0.387
  CowLiveOverMeat = 1 / CowMeatOverLive
  CowHangingOverLive = 0.553
  CowLiveOverHanging = 1 / CowHangingOverLive
  PigMeatOverHanging = 0.66
  PigHangingOverMeat = 1 / PigMeatOverHanging
  PigMeatOverLive = 0.48
  PigLiveOverMeat = 1 / PigMeatOverLive
  PigHangingOverLive = 0.72
  PigLiveOverHanging = 1 / PigHangingOverLive
  LambMeatOverHanging = 0.8
  LambHangingOverMeat = 1 / LambMeatOverHanging
  LambMeatOverLive = 0.4
  LambeLiveOverMeat = 1 / LambMeatOverLive
  LambHangingOverLive = 0.5
  LambLiveOverHanging = 1 / LambHangingOverLive
  GoatMeatOverHanging = 0.625
  GoatHangingOverMeat = 1 / GoatMeatOverHanging
  GoatMeatOverLive = 0.344
  GoatLiveOverMeat = 1 / GoatMeatOverLive
  GoatHangingOverLive = 0.5504
  GoatLiveOverHanging = 1 / GoatHangingOverLive
end