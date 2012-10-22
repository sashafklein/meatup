# Cuts
	Cut.delete_all
	# The Real Paul Ryan
	london = Cut.create(
		:animal_type => "Cow",
		:name => "London Broil",
	  	:price => 4,
	  	:package_weight => 2,
	  	:percent => 1.67,
	  	:comp => 7.99,
	  	:savings => 50
  	)
	ground = Cut.create(
		:animal_type => "Cow",
		:name => "Ground Beef",
	  	:price => 2.63,
	  	:package_weight => 1,
	  	:percent => 7.67,
	  	:comp => 6.99,
	  	:savings => 62
  	) 
  	stew = Cut.create(
		:animal_type => "Cow",
		:name => "Beef Stew",
	  	:price => 2.78,
	  	:package_weight => 2.22,
	  	:percent => 4.25,
	  	:comp => 7.99,
	  	:savings => 65
  	)
  	brisket = Cut.create(
		:animal_type => "Cow",
		:name => "Brisket",
	  	:price => 5.35,
	  	:package_weight => 4,
	  	:percent => 0.67,
	  	:comp => 8.99,
	  	:savings => 40
  	)
  	cross = Cut.create(
		:animal_type => "Cow",
		:name => "Cross Rib",
	  	:price => 4.5,
	  	:package_weight => 3.38,
	  	:percent => 2.25,
	  	:comp => 7.99,
	  	:savings => 44,
	  	:incentive => true
  	)
  	rump = Cut.create(
		:animal_type => "Cow",
		:name => "Rump Steak",
	  	:price => 5.55,
	  	:package_weight => 3.5,
	  	:percent => 0.58,
	  	:comp => 8.99,
	  	:savings => 38
  	)
  	short = Cut.create(
		:animal_type => "Cow",
		:name => "Short Ribs",
	  	:price => 5.55,
	  	:package_weight => 3.33,
	  	:percent => 1.67,
	  	:comp => 8.99,
	  	:savings => 38
  	)
  	eye = Cut.create(
		:animal_type => "Cow",
		:name => "Eye of Round",
	  	:price => 5.25,
	  	:package_weight => 3.50,
	  	:percent => 0.58,
	  	:comp => 9.99,
	  	:savings => 47
  	)
  	bottom = Cut.create(
		:animal_type => "Cow",
		:name => "Bottom Round",
	  	:price => 6.55,
	  	:package_weight => 4,
	  	:percent => 0.67,
	  	:comp => 8.99,
	  	:savings => 27,
	  	:incentive => true
  	)
  	tri = Cut.create(
		:animal_type => "Cow",
		:name => "Tri Tip",
	  	:price => 8.1,
	  	:package_weight => 2,
	  	:percent => 0.67,
	  	:comp => 9.99,
	  	:savings => 19
  	)
  	flank = Cut.create(
		:animal_type => "Cow",
		:name => "Flank",
	  	:price => 5.55,
	  	:package_weight => 1.5,
	  	:percent => 0.25,
	  	:comp => 11.99,
	  	:savings => 54
  	)
  	chuck = Cut.create(
		:animal_type => "Cow",
		:name => "Chuck Roast",
	  	:price => 7.6,
	  	:package_weight => 3.9,
	  	:percent => 3.25,
	  	:comp => 9.99,
	  	:savings => 24
  	)
  	hanger = Cut.create(
		:animal_type => "Cow",
		:name => "Hanger Steak",
	  	:price => 7.8,
	  	:package_weight => 0,
	  	:percent => 0,
	  	:comp => 10.99,
	  	:savings => 0
  	)
  	flat = Cut.create(
		:animal_type => "Cow",
		:name => "Flat Iron",
	  	:price => 8.15,
	  	:package_weight => 0,
	  	:percent => 0,
	  	:comp => 13.99,
	  	:savings => 0
  	)
  	top = Cut.create(
		:animal_type => "Cow",
		:name => "Top Sirloin Steak",
	  	:price => 10.9,
	  	:package_weight => 1.56,
	  	:percent => 1.17,
	  	:comp => 11.99,
	  	:savings => 9
  	)
  	skirt = Cut.create(
		:animal_type => "Cow",
		:name => "Skirt",
	  	:price => 13.2,
	  	:package_weight => 1.25,
	  	:percent => 0.42,
	  	:comp => 14.99,
	  	:savings => 12
  	)
  	porter = Cut.create(
		:animal_type => "Cow",
		:name => "Porterhouse",
	  	:price => 13.05,
	  	:package_weight => 2.6,
	  	:percent => 1.08,
	  	:comp => 17.99,
	  	:savings => 27
  	)
  	t = Cut.create(
		:animal_type => "Cow",
		:name => "T-Bone",
	  	:price => 15.05,
	  	:package_weight => 2,
	  	:percent => 1.17,
	  	:comp => 16.99,
	  	:savings => 11
  	)
  	ribeye = Cut.create(
		:animal_type => "Cow",
		:name => "Ribeye",
	  	:price => 15.75,
	  	:package_weight => 2,
	  	:percent => 1.83,
	  	:comp => 20.99,
	  	:savings => 25
  	)
  	ny = Cut.create(
		:animal_type => "Cow",
		:name => "NY Strip",
	  	:price => 15.7,
	  	:package_weight => 0,
	  	:percent => 0,
	  	:comp => 19.99,
	  	:savings => 0
  	)
  	filet = Cut.create(
		:animal_type => "Cow",
		:name => "Filet Mignon Tenderloin",
	  	:price => 20,
	  	:package_weight => 1.5,
	  	:percent => 0.25,
	  	:comp => 29.99,
	  	:savings => 33
  	)
  	sirloin = Cut.create(
		:animal_type => "Cow",
		:name => "Sirloin Tip",
	  	:price => 8.1,
	  	:package_weight => 1.1,
	  	:percent => 0.25,
	  	:comp => 9.99,
	  	:savings => 19
  	)
  	shank = Cut.create(
		:animal_type => "Cow",
		:name => "Shank",
	  	:price => 3,
	  	:package_weight => 2.64,
	  	:percent => 2.42,
	  	:comp => 3,
	  	:savings => 0
  	)
  	knuckle = Cut.create(
		:animal_type => "Cow",
		:name => "Knuckle Bones",
	  	:price => 3,
	  	:package_weight => 4.75,
	  	:percent => 1.58,
	  	:comp => 3,
	  	:savings => 0,
	  	:incentive => true
  	)
  	fat = Cut.create(
		:animal_type => "Cow",
		:name => "Suet Fat",
	  	:price => 3,
	  	:package_weight => 1.8,
	  	:percent => 0.75,
	  	:comp => 3,
	  	:savings => 0,
	  	:incentive => true
  	)
  	kidney = Cut.create(
		:animal_type => "Cow",
		:name => "Kidney",
	  	:price => 3,
	  	:package_weight => 2,
	  	:percent => 0.17,
	  	:comp => 3,
	  	:savings => 0,
	  	:incentive => true
  	)
  	offal = Cut.create(
		:animal_type => "Cow",
		:name => "Offal",
	  	:price => 3,
	  	:package_weight => 1.31,
	  	:percent => 1.42,
	  	:comp => 3,
	  	:savings => 0,
	  	:incentive => true
  	)
  	flap = Cut.create(
		:animal_type => "Cow",
		:name => "Flap Meat",
	  	:price => 3,
	  	:package_weight => 1.5,
	  	:percent => 0.50,
	  	:comp => 3,
	  	:savings => 0,
	  	:incentive => true
  	)
  	neck = Cut.create(
		:animal_type => "Cow",
		:name => "Neck",
	  	:price => 3,
	  	:package_weight => 4.75,
	  	:percent => 1.58,
	  	:comp => 3,
	  	:savings => 0
  	)

  	#Pig Cuts
  	Cut.create(
		:animal_type => "Pig",
		:name => "Bacon",
	  	:price => 7,
	  	:package_weight => 1,
	  	:percent => 3,
	  	:comp => 1, 
	  	:savings => 0
  	)
  	Cut.create(
		:animal_type => "Pig",
		:name => "Pork Chop",
	  	:price => 10,
	  	:package_weight => 2,
	  	:percent => 5
  	)

  	# Other Cuts

  	Cut.create(
		:animal_type => "Goat",
		:name => "Goat Stew",
	  	:price => 7,
	  	:package_weight => 2,
	  	:percent => 3
  	)

# Users
	User.delete_all
	one = User.create(
		:name => "One",
		:email => "one@test.com",
		:password => "password",
		:password_confirmation => "password",
		:zip => "94114"
	)
	two = User.create(
		:name => "Two",
		:email => "two@test.com",
		:password => "password",
		:password_confirmation => "password",
		:zip => "94114"
	)
	miller_ranch_user = User.create(
		:name => "Miler Ranch",
		:email => "miller_ranch@meatup.in",
		:password => "password",
		:password_confirmation => "password",
		:zip => "94114"
	)
	clark_summit_user = User.create(
		:name => "Clark Summit Farm",
		:email => "clark_summit@meatup.in",
		:password => "password",
		:password_confirmation => "password",
		:zip => "94114"
	)
	sanders_user = User.create(
		:name => "Sanders Ranch",
		:email => "sanders@meatup.in",
		:password => "password",
		:password_confirmation => "password",
		:zip => "94114"
	)
	buds_custom_user = User.create(
		:name => "Buds Custom Meats",
		:email => "buds_custom@meatup.in",
		:password => "password",
		:password_confirmation => "password",
		:zip => "94114"
	)

# Butchers
	Butcher.delete_all
	sanders = Butcher.create(
		:name => "Sanders Meat Co",
		:address => "Turlock St.",
		:city => "Turlock",
		:state => "CA",
		:zip => "94114",
		:phone => "999-999-9999",
		:hanging_price => 0.55,
		:final_price => 0,
		:wrap_price => 0,
		:vacuum_price => 0.00,
		:ground => true,
		:stew => true,
		:boneless => true,
		:user_id => one.id
	)

	buds_custom = Butcher.create(
		:name => "Bud's Custom Meats",
		:address => "Turlock St.",
		:city => "Turlock",
		:state => "CA",
		:zip => "94114",
		:phone => "999-999-9999",
		:hanging_price => 0.80,
		:final_price => 0,
		:wrap_price => 0,
		:vacuum_price => 0.00,
		:ground => true,
		:stew => true,
		:boneless => true,
		:user_id => buds_custom_user.id
	)

# Ranches
	Ranch.delete_all

	blank_ranch = Ranch.create(
		:name => "Blank",
		:address => "Address",
		:phone => "Number",
		:state => "CA",
		:city => "Tomales",
		:zip => "94971",
		:has_csa => true,
		:delivers_butcher => true,  
		:delivers_drop => true,  # Let's set this to ~50 mi radius from "city center"? Translates to delivery cost estimate
		:delivers_host => true,  # Eliminates delivery cost estimate add-on
		:cow => false,
		:cow_live => 000,
		:cow_hanging => 000,
		:cow_fixed => 100,
		:preferred_butcher => blank_butcher.id,
		:pig => false,
		:pig_live => 000,
		:pig_hanging => 000,
		:pig_fixed => 100,
		:lamb => false,
		:lamb_live => 000,
		:lamb_hanging => 000,
		:lamb_fixed => 100,
		:goat => false,
		:goat_live => 000,
		:goat_hanging => 000,
		:goat_fixed => 100,
		:user_id => blank_ranch.id
	)

	miller_ranch = Ranch.create(
		:user_id => miller_ranch.id,
		:name => "Miller Ranch",
		:address => "Ranch Road",
		:phone => "999-999-9999",
		:state => "CA",
		:city => "Oakdale",
		:zip => "94114",
		:has_csa => true,
		:preferred_butcher => sanders.id,
		:delivers_butcher => true,
		:delivers_drop => true,
		:delivers_host => false,
		:cow => true,
		:cow_live => 1.40,
		:pig => false,
		:lamb => false,
		:goat => false
	)

	clark_summit = Ranch.create(
		:name => "Clark Summit Farm",
		:address => "30201 Shoreline Highway",
		:phone => "707-876-3516",
		:state => "CA",
		:city => "Tomales",
		:zip => "94971",
		:has_csa => true,
		:delivers_butcher => true,
		:delivers_drop => false,
		:delivers_host => true,
		:cow => true,
		:cow_hanging => 3.75,
		:cow_fixed => 100,
		:preferred_butcher => buds_custom.id,
		:pig => true,
		:pig_hanging => 4.00,
		:pig_fixed => 60,
		:lamb => false,
		:goat => false,
		:user_id => clark_summit_user.id
	)

# Hosts
	Host.delete_all
	klein = Host.create(
		:state => "CA",
		:phone => "later",
		:city => "San Francisco",
		:zip => "94114",
		:address => "3976 23rd St.",
		:user_id => one.id
	)

# Animals
	Animal.delete_all
	paul = Animal.create(
		:breed => "Black Angus", 
		:name => "Paul Ryan", 
		:photo => "Animals/PaulRyan.jpg", 
		:animal_type => "Cow",  
        :weight => 1216, 
        :ranch_id => miller.id, 
        :butcher_id => sanders.id,
        :host_id => klein.id
	)

# Real Users (with orders)
Order.delete_all

	jasper = User.create(
		:name => "Jasper Sherman-Presser",
		:email => "sashafklein@gmail.com",
		:password => "password",
		:password_confirmation => "password",
		:zip => "94114"
	)

		jasper_1 = Order.create(
			:status => 0,
			:animal_id => paul.id,
			:user_id => jasper.id
		)
			Line.create(
				:order_id => jasper_1.id,
				:cut_id => stew.id,
				:units => 2
			)
			Line.create(
				:order_id => jasper_1.id,
				:cut_id => ribeye.id,
				:units => 1
			)
			Line.create(
				:order_id => jasper_1.id,
				:cut_id => ground.id,
				:units => 4
			)
			Line.create(
				:order_id => jasper_1.id,
				:cut_id => sirloin.id,
				:units => 2
			)
			Line.create(
				:order_id => jasper_1.id,
				:cut_id => short.id,
				:units => 1
			)
			Line.create(
				:order_id => jasper_1.id,
				:cut_id => top.id,
				:units => 1
			)
