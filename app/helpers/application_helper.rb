module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "MeatUp"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def nice_bool(answer)
  	if answer == true
  		"Yes"
  	elsif answer == false
  		"No"
  	else
  		"Error"
  	end
  end
  
end
