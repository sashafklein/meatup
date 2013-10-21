class AnimalSaleCalculator
  attr_accessor :object, :type

  def initialize(model)
    return false if model.nil?
    @object = model
    @type = determine_sale_type
    start_or_end_sale_as_necessary!
  end

  def time_left
    opening_sale? ? [hours_left_string, mins_left_string].compact.join(" ") : ''
  end

  def message
    return nil unless any?
    
    case type
      when 'opening' then "Opening Sale on select cuts for the next #{sale.opening_time_left}!"
      when 'final' then "Final Sale on all cuts until #{object.name} is sold out!"
    end
  end

  def any?
    !type.blank?
  end

  def opening_sale?
    type == 'opening'
  end

  def final_sale?
    type == 'final'
  end

  def start_or_end_sale_as_necessary!
    object.start_final_sale! if should_start_final_sale
  end

  def should_start_final_sale
    object.percent_left < 20 && !final_sale?
  end

  def determine_sale_type
    return 'opening' if object.opening_sale? 
    return 'final' if object.final_sale?
    return ''
  end

  def hours_left
    (120 - time_since_object_creation / 60) / 60
  end

  def hours_left_string
    hours_left > 0 ? "#{hours_left} #{pluralize(hours_left, 'hour')}" : nil
  end

  def mins_left
    (120 - time_since_object_creation / 60) % 60
  end

  def mins_left_string
    mins_left > 0 ? "#{mins_left} #{pluralize(mins_left, 'minute')}" : nil
  end

  def time_since_object_creation
    Time.now.to_i - object.created_at.to_i
  end
end