class AnimalType

  attr_accessor :type_string

  def initialize(type_string)
    @type_string = type_string
  end

  def self.list
    %w( cow pig lamb goat )
  end

  def self.capitalized_list
    list.map(&:capitalize)
  end

  def self.meat_list
    list.map(&:meat)
  end

  def self.active_list
    list.select{ |animal_type| AnimalType.new(animal_type).real_animals.any? }
  end

  def real_animals
    Animal.where(animal_type: type_string)
  end

  def meat
    case type_string
      when "cow"  then "beef"
      when "pig"  then "pork"
      when "lamb" then "lamb"
      when "goat" then "goat"
    end
  end

end