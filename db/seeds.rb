# Animals
	Animal.delete_all
	Animal.create(
		:name => 'Paul Ryan',
	  	:animal_type => "Cow",
	  	:breed => "Black Angus",
	  	:weight => 1200,
	  	:farm => "Miller Ranch",
	  	:host => "The Kleins",
	  	:photo => "NA"
	)
	# . . .
	Animal.create(
		:name => 'Donald Trump',
	  	:animal_type => "Pig",
	  	:breed => "Hungarian",
	  	:weight => 800,
	  	:farm => "The Piggie Farm",
	  	:host => "The Kleins",
	  	:photo => "NA"
	)
	# . . .
	Animal.create(
		:name => 'Mitt Romney',
	  	:animal_type => "Goat",
	  	:breed => "Mountain",
	  	:weight => 120,
	  	:farm => "Mt. Diablo",
	  	:host => "The Kleins",
	  	:photo => "NA"
	)

# Cuts
	Cut.delete_all
	Cut.create(
		:animal_type => "Cow",
		:name => "Ground Beef",
	  	:price => 3,
	  	:package_weight => 1,
	  	:percent => 9
  	) 
  	Cut.create(
		:animal_type => "Cow",
		:name => "Beef Stew",
	  	:price => 3.2,
	  	:package_weight => 2,
	  	:percent => 5
  	)
  	Cut.create(
		:animal_type => "Cow",
		:name => "Ribeye",
	  	:price => 14.5,
	  	:package_weight => 1.5,
	  	:percent => 1.7
  	)
  	Cut.create(
		:animal_type => "Cow",
		:name => "Tenderloin",
	  	:price => 27,
	  	:package_weight => 3,
	  	:percent => 0.5
  	)
  	Cut.create(
		:animal_type => "Pig",
		:name => "Bacon",
	  	:price => 7,
	  	:package_weight => 1,
	  	:percent => 3
  	)
  	Cut.create(
		:animal_type => "Pig",
		:name => "Pork Chop",
	  	:price => 10,
	  	:package_weight => 2,
	  	:percent => 5
  	)
  	Cut.create(
		:animal_type => "Goat",
		:name => "Goat Stew",
	  	:price => 7,
	  	:package_weight => 2,
	  	:percent => 3
  	)

# Orders
	Order.delete_all
	Order.create(
		:status => "Complete",
		:animal_id => 1
  	)
  	Order.create(
		:status => "Incomplete",
		:animal_id => 1
  	)
  	Order.create(
		:status => "Incomplete",
		:animal_id => 2
  	)

# Lines
	Line.delete_all
	Line.create(
		:units => 3,
		:notes => "Bone-in",
		:order_id => 1
	)
	Line.create(
		:units => 1,
		:notes => "Whole",
		:order_id => 1
	)
	Line.create(
		:units => 10,
		:notes => "10% Fat",
		:order_id => 1
	)
	Line.create(
		:units => 3,
		:notes => "Lean",
		:order_id => 2
	)
	Line.create(
		:units => 10,
		:notes => "Hickory Smoked",
		:order_id => 3
	)


