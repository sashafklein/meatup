module Order::StatusMethods
  
  def status_description
    case status
    when 0
      "incomplete"
    when 1
      "downpaid"
    when 2
      "paid"
    when 3
      "complete"
    end
  end

  def bill_status
    array = ["Incomplete", "Deposited", "Final Price Paid", "Picked Up"]
    array[status]
  end

  def incomplete?
    status == 0
  end

  def downpaid?
    status == 1
  end

  def paid? 
    status == 2
  end

  def not_paid?
    status < 2
  end

  def complete?
    status == 3
  end
  
end