class RealCutDecorator < Draper::Decorator
  delegate_all

  def available
    (0..units_left).to_a
  end

  def list_dollars
    h.number_to_currency(list_price / 100)
  end

  def flat_dollars
    h.number_to_currency (flat_price / 100)
  end

  def display_weight
    h.present_weight weight
  end

  def display_savings
    h.display_savings (savings * 100)
  end

  def savings_class
    h.savings_class (savings * 100)
  end

  def name_cell
    if model.discounted?
      h.content_tag :div, id: 'on_sale', title: model.description do
        h.raw [model.name, discount_cell].join(" ")
      end
    else
      h.content_tag :div, id: 'cut_name', title: model.description do
        model.name
      end
    end
  end

  def discount_cell
    h.content_tag :strong, class: 'sale_note' do
      model.sale_message
    end
  end
 
  def prep_select(form)
    if model.prep_options.length > 1
      form.select :notes, model.prep_options
    end
  end

  def display_lbs_sold
    h.present_weight pounds_sold
  end

end