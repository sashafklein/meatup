class AnimalSale::OpeningSale
  
  attr_reader :animal

  PERCENT_LEFT = 80
  HOURS_INTO = 2
  TIME_INTO = HOURS_INTO * 60 * 60
  PRICE_MULTIPLE = 0.9

  def initialize(animal)
    @animal = animal
  end
  
  def message
    "Opening Sale on select cuts for the next #{display_time_left}!"
  end

  def move!
    move_to! AnimalSale::NoSale.new( animal )
  end

  def move?
    time_out? || over_bought?
  end

  def price_multiple
    PRICE_MULTIPLE
  end

  def type
    'opening'
  end

  private

  def time_out?
    seconds_left <= 0
  end

  def over_bought?
    animal.percent_left <= PERCENT_LEFT
  end




#########################
## TIMEOUT LOGIC BELOW ##
#########################

  def display_time_left
    [hours_left_string, mins_left_string].compact.join(" ")
  end

  def seconds_left
    TIME_INTO - time_since_creation
  end

  def hours_left
    (seconds_left / 1.hour).floor
  end

  def mins_left
    (seconds_left / 1.minute).floor
  end

  def remainder_mins_left
    mins_left % 60
  end

  def hours_left_string
    hours_left > 0 ? "#{hours_left} #{pluralize(hours_left, 'hour')}" : nil
  end

  def mins_left_string
    mins_left > 0 ? "#{mins_left} #{pluralize(remainder_mins_left, 'minute')}" : nil
  end

  def time_since_creation
    Time.now.to_i - animal.created_at.to_i
  end
end