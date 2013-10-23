class PrepOption
  
  def initialize(cut, animal)
    @cut = cut
    @butcher = animal.butcher
    @options = prepare(cut.prep_options)
  end

  def butcher
    @butcher
  end

  def butcher_list
    untranslated = [:ground, :stew, :boneless].select{ |prep| nullify butcher.send(prep) }.compact
    untranslated.map do |prep|
      case prep
      when :ground then "grind"
      when :stew then "stew"
      when :boneless then "debone"
      end
    end.unshift("none")
  end

  def cut_list
    @options
  end

  def order_list
    (cut_list & butcher_list).map{ |option| for_order(option) }
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

  # Returns true or nil
  def nullify(bool)
    bool ? bool : nil
  end
end