class OpeningSale < AnimalSale
  
  attr_reader :animal

  DISCOUNT = 0.9
  PERCENT_LEFT = 80
  HOURS_INTO = 2
  TIME_INTO = HOURS_INTO * 60 * 60

  def initialize(animal)
    @animal = animal
  end

  def should_end?
    animal.percent_left < PERCENT_LEFT || time_into > TIME_INTO
  end

  def end!
    return false unless should_end?

    update_packages!
    animal.update_attribute(:final_sale, true)
  end

  def should_start?
    # in this case, percent left is less than 20; otherwise this object wouldn't be created
    !animal.final_sale? 
  end

  def message
    "Opening Sale on select cuts for the next #{display_time_left}!"
  end




#########################
## TIMEOUT LOGIC BELOW ##
#########################

  def display_time_left
    [hours_left_string, mins_left_string].compact.join(" ")
  end

  def seconds_left
    Time.now - time_since_creation
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