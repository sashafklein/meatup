class PackagePricer

  attr_reader :cut, :animal
  
  def initialize(options = {})
    @cut = options[:cut]
    @animal = options[:animal]
  end

  def mult
    animal.mult
  end

  def normal
    return cut.price if animal.mult.nil?
    cut.price * animal.mult
  end

  def opening_sale
    normal * 0.9
  end

  def final_sale
    normal * 0.85
  end
end