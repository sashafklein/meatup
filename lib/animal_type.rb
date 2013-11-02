class AnimalType

  attr_accessor :type_string

  class NoSuchAnimalError < Exception; end

  def initialize(type_string = '')
    @type_string = type_string.downcase
    raise NoSuchAnimalError if invalid_type_string
  end

  def self.list
    AnimalType.new.list
  end

  def self.instance_list
    AnimalType.new.instance_list
  end

  def instance_list
    list.map{ |item| AnimalType.new(item) }
  end

  def list
    %w( cow pig lamb goat )
  end

  def capitalized_list
    list.map(&:capitalize)
  end

  def meat_list
    list.map{ |e| AnimalType.new(e).meat }
  end

  def list_path
    { id: type }
  end

  def active_list
    list.select{ |animal| AnimalType.new(animal).real_animals.present? }
  end

  def real_animals
    Animal.where(animal_type: type_string)
  end

  def real_open
    real_animals.on_sale
  end

  def any_real_open?
    real_open.any?
  end

  def inspect
    type_string
  end

  def meat
    case type_string
      when "cow"  then "beef"
      when "pig"  then "pork"
      when "lamb" then "lamb"
      when "goat" then "goat"
    end
  end

  def type
    type_string
  end

  def name
    type
  end

  def cuts
    Cut.where(animal_type: type)
  end

  def others
    list.reject(&:type)
  end

  private

  def invalid_type_string
    type_string.present? && !list.include?(type_string)
  end

end