# Animals
	Animal.delete_all
	Animal.create(
		:name => 'Paul Ryan',
	  	:animal_type => "Cow",
	  	:breed => "Black Angus",
	  	:weight => 2000,
	  	:farm => "Miller Ranch",
	  	:host => "The Kleins",
	  	:photo => "NA",
	  	:ranch_id => 1,
	  	:butcher_id => 1,
	  	:multiplier => 1
	)
	Animal.create(
		:name => 'Donald Trump',
	  	:animal_type => "Pig",
	  	:breed => "Hungarian",
	  	:weight => 800,
	  	:farm => "The Piggie Farm",
	  	:host => "The Kleins",
	  	:photo => "NA",
	  	:ranch_id => 1,
	  	:butcher_id => 1,
	  	:multiplier => 1
	)
	Animal.create(
		:name => 'Ilias Kasidiaris',
	  	:animal_type => "Lamb",
	  	:breed => "Greek",
	  	:weight => 150,
	  	:farm => "Mt. Tam",
	  	:host => "The Kleins",
	  	:photo => "NA",
	  	:ranch_id => 1,
	  	:butcher_id => 1,
	  	:multiplier => 1
	)
	Animal.create(
		:name => 'Mitt Romney',
	  	:animal_type => "Goat",
	  	:breed => "Mountain",
	  	:weight => 200,
	  	:farm => "Mt. Diablo",
	  	:host => "The Kleins",
	  	:photo => "NA",
	  	:ranch_id => 1,
	  	:butcher_id => 1,
	  	:multiplier => 1
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
	  	:package_weight => 2,
	  	:percent => 2
  	)
  	Cut.create(
		:animal_type => "Cow",
		:name => "Tenderloin",
	  	:price => 27,
	  	:package_weight => 5,
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

# Packages
 	Package.delete_all
 	Package.create(
 		:original => 90,
 		:left => 90,
 		:cut_id => 1,
 		:animal_id => 1
 	)
 	Package.create(
 		:original => 25,
 		:left => 25,
 		:cut_id => 2,
 		:animal_id => 1
 	)
 	Package.create(
 		:original => 10,
 		:left => 10,
 		:cut_id => 3,
 		:animal_id => 1
 	)
 	Package.create(
 		:original => 1,
 		:left => 1,
 		:cut_id => 4,
 		:animal_id => 1
 	)
 	Package.create(
 		:original => 24,
 		:left => 24,
 		:cut_id => 5,
 		:animal_id => 2
 	)
 	Package.create(
 		:original => 20,
 		:left => 20,
 		:cut_id => 6,
 		:animal_id => 2
 	)
 	Package.create(
 		:original => 3,
 		:left => 3,
 		:cut_id => 7,
 		:animal_id => 3
 	)
 	

# Orders
	Order.delete_all
	Order.create(
		:status => "Complete",
		:animal_id => 1,
		:user_id => 1
  	)
  	Order.create(
		:status => "Incomplete",
		:animal_id => 1,
		:user_id => 1
  	)
  	Order.create(
		:status => "Incomplete",
		:animal_id => 2,
		:user_id => 1
  	)

# Lines
	Line.delete_all
	Line.create(
		:units => 3,
		:notes => "Bone-in",
		:order_id => 1,
		:cut_id => 3
	)
	Line.create(
		:units => 1,
		:notes => "Whole",
		:order_id => 1,
		:cut_id => 4
	)
	Line.create(
		:units => 10,
		:notes => "10% Fat",
		:order_id => 1,
		:cut_id => 1
	)
	Line.create(
		:units => 3,
		:notes => "Lean",
		:order_id => 2,
		:cut_id => 2
	)
	Line.create(
		:units => 10,
		:notes => "Hickory Smoked",
		:order_id => 3,
		:cut_id => 5 
	)

# Users
	User.delete_all
	User.create(
		:name => "One",
		:email => "one@test.com",
		:password => "password",
		:password_confirmation => "password"
	)
	User.create(
		:name => "Two",
		:email => "two@test.com",
		:password => "password",
		:password_confirmation => "password"
	)

# Butchers
	Butcher.delete_all
	Butcher.create(
		:name => "Sanders Meat Co",
		:address => "Turlock",
		:phone => "999-999-9999",
		:hanging_price => 0,
		:final_price => 0.60,
		:wrap_price => 0,
		:vacuum_price => 0.15,
		:user_id => 1,
		:ground => true,
		:stew => true,
		:boneless => true
	)

# Ranches
	Ranch.delete_all
	Ranch.create(
		:name => "Miller Ranch",
		:address => "Livermoor",
		:phone => "999-999-9999",
		:cow => true,
		:cow_live => 2.25
	)