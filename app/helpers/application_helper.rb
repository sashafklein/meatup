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

  # Formats bool answers to display as yes or no.
  def nice_bool(answer)
  	if answer == true
  		"Yes"
  	else
  		"No"
  	end
  end
  
end
