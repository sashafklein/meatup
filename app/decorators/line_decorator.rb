class LineDecorator < Draper::Decorator
  delegate_all

  def cut_name
    model.real_cut.name
  end

  def weight
    if model.weighed?
      h.present_weight(model.weighed_pounds)
    else
      h.present_weight(model.real_cut.weight * model.units)
    end
  end

  def to_pay
    if model.order.incomplete?
      h.number_to_currency(model.revenue / 100)
    else
      if model.weight_diff
        h.present_weight model.weight_diff
      else
        'Unknown'
      end
    end
  end

  def discounted?
    0 < (model.real_cut.flat_price - model.sale_price) / 100
  end

  def discounted
    discount = (model.real_cut.flat_price - model.sale_price) / 100
    if discount > 0
      h.content_tag :em do
        "- #{h.number_to_currency(discount)}!"
      end
    end
  end
end