class OrderDecorator < Draper::Decorator
  delegate_all

  def lines
    LineDecorator.decorate_collection(model.lines)
  end

  def to_pay
    h.content_tag :b do 
      if model.incomplete?
        "Downpayment: #{h.number_to_currency(model.downpay_total / 100)}"
      else
        "Remaining: #{number_to_currency(model.get_difference)}"
      end
    end
  end

  def weight_kind
    if model.incomplete? 
      "Total Lbs"
    else
      "Weight Difference"
    end
  end

  def price_note
    if model.apology_priced?
      "(Discounted) Price"
    else
      "Price"
    end
  end

  def timer_stamp(params)
    h.content_tag :div, class: 'timer_stamp', id: 'timer', data: params do
      "TIME\nLEFT TO PAY"
    end
  end

  def receipt_stamp
    h.content_tag :div, class: 'receipt_stamp' do
      "#{receipt_stamp_top}\n#{receipt_stamp_bottom}"
    end
  end

  def receipt_stamp_top
    case model.status_description
    when "incomplete" then "ORDER"
    when "downpaid"   then "DEPOSIT RECEIVED"
    when "paid"       then "FINAL BILL"
    when "complete"   then "FINAL ORDER"
    end
  end

  def receipt_stamp_bottom
    case model.status_description
    when "incomplete" then "STATUS"
    when "downpaid"   then "WITH THANKS"
    when "paid"       then "FULLY PAID"
    when "complete"   then "RECEIVED"
    end
  end

  def header_row(string)
    h.content_tag :tr do
      h.content_tag :td, class: 'details', colspan: "5" do
        string
      end
    end
  end

  def customer_name_row
    header_row "Customer Name: #{model.user.name}"
  end

  def animal_name_row
    header_row "Animal Name: #{model.animal.name}"
  end

  def bill_status_row
    header_row h.raw("Order Status: <b style='font-weight:normal;color:#9a393a;'>#{model.bill_status}</b>")
  end

  def apology_discount_row
    if model.apology_priced?
      header_row h.raw('<strong>10% "Apology Discount" applied to all cuts!')
    end
  end

  def stripe_data
    {
      data:
        {
          amount: stripe_total, 
          description: "#{model.animal.name} Final Payment",
          key: Rails.configuration.stripe[:publishable_key]
        },
      src: "https://button.stripe.com/v1/button.js"
    }
  end

  def stripe_total
    if model.incomplete?
      0.8 * model.total
    else
      model.get_difference + 0.2 * model.total
    end
  end
end