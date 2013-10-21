class PrepOption
  
  def initialize(cut)
    @cut = cut
    @options = prepare(cut.prep_options)
  end

  def list
    @options
  end

  def order_list
    list.map{ |option| for_order(option) }
  end

  def for_order(option)
    case option
    when "grind" then "Grind"
    when "stew" then "Turn to stew"
    when "debone" then "Debone"
    else "None"
    end
  end

  def prepare(options)
    starter = options.present? ? options.split.reject{ |e| e == "none" } : []
    ["none"] + starter
  end
end