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
	  	:savings => 50, 
	  	:description => "'London Broil' was first a preparation technique, but became the name for the two cuts -- Flank and, increasingly, Top Round -- that the technique applied to."
  	)
	ground = Cut.create(
		:animal_type => "Cow",
		:name => "Ground Beef",
	  	:price => 2.63,
	  	:package_weight => 1,
	  	:percent => 7.67,
	  	:comp => 6.99,
	  	:savings => 62,
	  	:description => "Burgers, meatballs, meatloaf and beef moussaka."
  	) 
  	stew = Cut.create(
		:animal_type => "Cow",
		:name => "Beef Stew",
	  	:price => 2.78,
	  	:package_weight => 2.22,
	  	:percent => 4.25,
	  	:comp => 7.99,
	  	:savings => 65, 
	  	:description => "Tagine, bourgignon, pot au feu, chili, and a good old fashioned beef stew."
  	)
  	brisket = Cut.create(
		:animal_type => "Cow",
		:name => "Brisket",
	  	:price => 5.35,
	  	:package_weight => 4,
	  	:percent => 0.67,
	  	:comp => 8.99,
	  	:savings => 40,
	  	:description => "The classic roasting/braising/BBQ/Passover cut from just below the chuck at the front of the animal."
  	)
  	cross = Cut.create(
		:animal_type => "Cow",
		:name => "Cross Rib",
	  	:price => 4.5,
	  	:package_weight => 3.38,
	  	:percent => 2.25,
	  	:comp => 7.99,
	  	:savings => 44,
	  	:incentive => true, 
	  	:description => "Similar to the Chuck Roast, a braiser or roaster. Cook long and low."
  	)
  	rump = Cut.create(
		:animal_type => "Cow",
		:name => "Rump Steak",
	  	:price => 5.55,
	  	:package_weight => 3.5,
	  	:percent => 0.58,
	  	:comp => 8.99,
	  	:savings => 38, 
	  	:description => "One of Argentina/Brazil's favorites, less known in the states. Great flavor with a nice thick layer of fat. A crazy deal."
  	)
  	short = Cut.create(
		:animal_type => "Cow",
		:name => "Short Ribs",
	  	:price => 5.55,
	  	:package_weight => 3.33,
	  	:percent => 1.67,
	  	:comp => 8.99,
	  	:savings => 38, 
	  	:description => "A braising staple from the lower portions of the ribs. Undercook and they'll be unpleasantly chewy. Stew low and long to soften and release flavors."
  	)
  	eye = Cut.create(
		:animal_type => "Cow",
		:name => "Eye of Round",
	  	:price => 5.25,
	  	:package_weight => 3.50,
	  	:percent => 0.58,
	  	:comp => 9.99,
	  	:savings => 47, 
	  	:description => "A lean but relatively tender cut, the eye of the round is good for rare grilling or delicate braising."
  	)
  	bottom = Cut.create(
		:animal_type => "Cow",
		:name => "Bottom Round",
	  	:price => 6.55,
	  	:package_weight => 4,
	  	:percent => 0.67,
	  	:comp => 8.99,
	  	:savings => 27,
	  	:incentive => true, 
	  	:description => "A lean cut from the outer leg. Stew/braise for a while or grind up."
  	)
  	tri = Cut.create(
		:animal_type => "Cow",
		:name => "Tri Tip",
	  	:price => 8.1,
	  	:package_weight => 2,
	  	:percent => 0.67,
	  	:comp => 9.99,
	  	:savings => 19, 
	  	:description => "An increasingly popular cut (in SF particularly), for its rich flavor and thick layer of fat."
  	)
  	flank = Cut.create(
		:animal_type => "Cow",
		:name => "Flank",
	  	:price => 5.55,
	  	:package_weight => 1.5,
	  	:percent => 0.25,
	  	:comp => 11.99,
	  	:savings => 54, 
	  	:description => "A thin, tender, and (pleasantly) chewy steak from the abdomen. A favorite for marinated grilling."
  	)
  	chuck = Cut.create(
		:animal_type => "Cow",
		:name => "Chuck Roast",
	  	:price => 7.6,
	  	:package_weight => 3.9,
	  	:percent => 3.25,
	  	:comp => 9.99,
	  	:savings => 24, 
	  	:description => "A well-marbled, rich piece of steak best for braising and roasts (but also not bad in steaks)."
  	)
  	hanger = Cut.create(
		:animal_type => "Cow",
		:name => "Hanger Steak",
	  	:price => 7.8,
	  	:package_weight => 0,
	  	:percent => 0,
	  	:comp => 10.99,
	  	:savings => 0, 
	  	:description => "Used to be called the Butcher's Cut, because butchers would keep it for themselves. One of the most flavorful cuts for grilling/searing. From the inner skirt."
  	)
  	flat = Cut.create(
		:animal_type => "Cow",
		:name => "Flat Iron",
	  	:price => 8.15,
	  	:package_weight => 0,
	  	:percent => 0,
	  	:comp => 13.99,
	  	:savings => 0, 
	  	:description => "An increasingly popular cut for grilling or roasting. From the shoulder."
  	)
  	top = Cut.create(
		:animal_type => "Cow",
		:name => "Top Sirloin Steak",
	  	:price => 10.9,
	  	:package_weight => 1.56,
	  	:percent => 1.17,
	  	:comp => 11.99,
	  	:savings => 9, 
	  	:description => "Bread-and-butter grilling cut, with a nice cap of fat."
  	)
  	skirt = Cut.create(
		:animal_type => "Cow",
		:name => "Skirt",
	  	:price => 13.2,
	  	:package_weight => 1.25,
	  	:percent => 0.42,
	  	:comp => 14.99,
	  	:savings => 12, 
	  	:description => "This thin cut from the inner 'plate' is both chewy and tender."
  	)
  	porter = Cut.create(
		:animal_type => "Cow",
		:name => "Porterhouse",
	  	:price => 13.05,
	  	:package_weight => 2.6,
	  	:percent => 2.78,
	  	:comp => 17.99,
	  	:savings => 27, 
	  	:description => "A rich and satisfying steakhouse classic, from the short loin, in the lower ribs. A balance of sirloin steak and tenderloin, separated by a bone."
  	)
  	t = Cut.create(
		:animal_type => "Cow",
		:name => "T-Bone",
	  	:price => 15.05,
	  	:package_weight => 2,
	  	:percent => 1.17,
	  	:comp => 16.99,
	  	:savings => 11, 
	  	:description => "Another delicious two-part grilling/roasting cut, with Tenderloin and NY Strip on either side of a T Bone"
  	)
  	ribeye = Cut.create(
		:animal_type => "Cow",
		:name => "Ribeye",
	  	:price => 15.75,
	  	:package_weight => 2,
	  	:percent => 1.83,
	  	:comp => 20.99,
	  	:savings => 25, 
	  	:description => "An obscenely delicious steak cut from the upper ribs. Pan sear one of these and throw it in the oven for a handful of minutes."
  	)
  	ny = Cut.create(
		:animal_type => "Cow",
		:name => "NY Strip",
	  	:price => 15.7,
	  	:package_weight => 0,
	  	:percent => 0,
	  	:comp => 19.99,
	  	:savings => 0, 
	  	:description => ""
  	)
  	filet = Cut.create(
		:animal_type => "Cow",
		:name => "Filet Mignon Tenderloin",
	  	:price => 20,
	  	:package_weight => 1.5,
	  	:percent => 0.25,
	  	:comp => 29.99,
	  	:savings => 33, 
	  	:description => "A muscle that does very little work, tenderloin is an extremely tender steak. Sear briefly."
  	)
  	sirloin = Cut.create(
		:animal_type => "Cow",
		:name => "Sirloin Tip",
	  	:price => 8.1,
	  	:package_weight => 1.1,
	  	:percent => 1.99,
	  	:comp => 9.99,
	  	:savings => 19, 
	  	:description => "Peeled off the top sirloin, this cut is great for cooking quick and high."
  	)
  	shank = Cut.create(
		:animal_type => "Cow",
		:name => "Shank",
	  	:price => 3,
	  	:package_weight => 2.64,
	  	:percent => 2.42,
	  	:comp => 3,
	  	:savings => 0, 
	  	:description => "A ring off of the weight-bearing front or back legs, these shanks are great for stews and braises, and come with a marrow bone."
  	)
  	knuckle = Cut.create(
		:animal_type => "Cow",
		:name => "Bones",
	  	:price => 3,
	  	:package_weight => 1.84,
	  	:percent => 0.61,
	  	:comp => 3,
	  	:savings => 0,
	  	:incentive => true, 
	  	:description => "Beef bones, full of flavor. Just roast these for a few minutes to darken them, and throw them in a soup."
  	)
  	fat = Cut.create(
		:animal_type => "Cow",
		:name => "Suet Fat",
	  	:price => 3,
	  	:package_weight => 1.8,
	  	:percent => 0.4,
	  	:comp => 3,
	  	:savings => 0,
	  	:incentive => true, 
	  	:description => "Rich, pure suet fat from around the kidneys. Rendered, this makes great cooking fat, with its rich taste and high smoke point."
  	)
  	kidney = Cut.create(
		:animal_type => "Cow",
		:name => "Kidney",
	  	:price => 3,
	  	:package_weight => 2,
	  	:percent => 0.17,
	  	:comp => 3,
	  	:savings => 0,
	  	:incentive => true, 
	  	:description => "Dense and flavorful, sear these up quickly or throw them in a rich stew."
  	)
  	offal = Cut.create(
		:animal_type => "Cow",
		:name => "Offal",
	  	:price => 3,
	  	:package_weight => 1.31,
	  	:percent => 1.42,
	  	:comp => 3,
	  	:savings => 0,
	  	:incentive => true, 
	  	:description => "Heart, tongue, cheek, and everyone's favorite, liver."
  	)
  	flap = Cut.create(
		:animal_type => "Cow",
		:name => "Flap Meat",
	  	:price => 3,
	  	:package_weight => 1.5,
	  	:percent => 0.50,
	  	:comp => 3,
	  	:savings => 0,
	  	:incentive => true, 
	  	:description => "From stringy diaphrams throughout the cow, this layered meat is chewy as hell when undercooked, but becomes unbelievably moist and soft when slow-roasted."
  	)
  	neck = Cut.create(
		:animal_type => "Cow",
		:name => "Neck",
	  	:price => 3,
	  	:package_weight => 4.75,
	  	:percent => 1.58,
	  	:comp => 3,
	  	:savings => 0, 
	  	:description => "Thick, chewy, and meaty, the neck meat radiates out from the neckbone and is great for longs braises or barbecues."
  	)

  	#Pig Cuts
  	Cut.create(
		:animal_type => "Pig",
		:name => "Bacon",
	  	:price => 7,
	  	:package_weight => 1,
	  	:percent => 3,
	  	:comp => 1, 
	  	:savings => 0, 
	  	:description => "Yum."
  	)
  	Cut.create(
		:animal_type => "Pig",
		:name => "Pork Chop",
	  	:price => 10,
	  	:package_weight => 2,
	  	:percent => 5, 
	  	:description => ""
  	)

  	# Other Cuts

  	Cut.create(
		:animal_type => "Goat",
		:name => "Goat Stew",
	  	:price => 7,
	  	:package_weight => 2,
	  	:percent => 3, 
	  	:description => ""
  	)

# Users
	User.delete_all
	sasha = User.create(
		:name => "Sasha Klein",
		:email => "sasha@meatup.in",
		:password => "password",
		:password_confirmation => "password",
		:zip => "94114"
	)
	sasha.toggle!(:admin)
	niko = User.create(
		:name => "Niko Klein",
		:email => "niko@meatup.in",
		:password => "password",
		:password_confirmation => "password",
		:zip => "94114", 
		:is_host => true
	)
	two = User.create(
		:name => "Two",
		:email => "two@meatup.in",
		:password => "password",
		:password_confirmation => "password",
		:zip => "94114"
	)
	miller_ranch_user = User.create(
		:name => "Miler Ranch",
		:email => "miller_ranch@meatup.in",
		:password => "password",
		:password_confirmation => "password",
		:zip => "94114",
		:is_rancher => true
	)
	clark_summit_user = User.create(
		:name => "Clark Summit Farm",
		:email => "clark_summit@meatup.in",
		:password => "password",
		:password_confirmation => "password",
		:zip => "94114", 
		:is_rancher => true
	)
	sanders_user = User.create(
		:name => "Sanders Butcher Person",
		:email => "sanders@meatup.in",
		:password => "password",
		:password_confirmation => "password",
		:zip => "94114",
		:is_butcher => true
	)
	buds_custom_user = User.create(
		:name => "Buds Custom Meats",
		:email => "buds_custom@meatup.in",
		:password => "password",
		:password_confirmation => "password",
		:zip => "94114", 
		:is_butcher => true
	)
	gleason_user = User.create(
		:name => "Nancy",
		:email => "infoatgleasonranch@meatup.in",
		:password => "password",
		:password_confirmation => "password",
		:zip => "94114", 
		:is_butcher => true,
		:is_rancher => true
	)
	godfrey_user = User.create(
		:name => "Godfrey",
		:email => "speechatthespeechworks@meatup.in",
		:password => "password",
		:password_confirmation => "password",
		:zip => "94114", 
		:is_rancher => true
	)
	devils_gulch_user = User.create(
		:name => "Mark Pasternak",
		:email => "markatdevilsgulchranch@meatup.in",
		:password => "password",
		:password_confirmation => "password",
		:zip => "94114",
		:is_rancher => true
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
		:user_id => sanders_user.id,
	)
	sanders_user.update_attribute(:butcher_id, sanders.id)

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
	buds_custom_user.update_attribute(:butcher_id, buds_custom.id)

	gleason_butcher = Butcher.create(
		:name => "FIX NAME",
		:address => "Turlock St.",
		:city => "Turlock",
		:state => "CA",
		:zip => "94114",
		:phone => "999-999-9999",
		:hanging_price => 0.75,
		:final_price => 0,
		:wrap_price => 0,
		:vacuum_price => 0.00,
		:ground => true,
		:stew => true,
		:boneless => true,
		:user_id => gleason_user.id,
	)
	gleason_user.update_attribute(:butcher_id, gleason_butcher.id)

# Ranches
	Ranch.delete_all

	# blank_ranch = Ranch.create(
	# 	:name => "Blank",
	# 	:address => "Address",
	# 	:phone => "Number",
	# 	:state => "CA",
	# 	:city => "Tomales",
	# 	:zip => "94971",
	# 	:has_csa => true,
	# 	:delivers_butcher => true,  
	# 	:delivers_drop => true,  # Let's set this to ~50 mi radius from "city center"? Translates to delivery cost estimate
	# 	:delivers_host => true,  # Eliminates delivery cost estimate add-on
	# 	:cow => false,
	# 	:cow_live => 000,
	# 	:cow_hanging => 000,
	# 	:cow_fixed => 100,
	# 	:preferred_butcher => blank_butcher.id,
	# 	:pig => false,
	# 	:pig_live => 000,
	# 	:pig_hanging => 000,
	# 	:pig_fixed => 100,
	# 	:lamb => false,
	# 	:lamb_live => 000,
	# 	:lamb_hanging => 000,
	# 	:lamb_fixed => 100,
	# 	:goat => false,
	# 	:goat_live => 000,
	# 	:goat_hanging => 000,
	# 	:goat_fixed => 100,
	# 	:user_id => blank_ranch_user.id
	# )

	miller_ranch = Ranch.create(
		:user_id => miller_ranch_user.id,
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
	miller_ranch_user.update_attribute(:ranch_id, miller_ranch.id)

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
	clark_summit_user.update_attribute(:ranch_id, clark_summit.id)

	gleason_ranch = Ranch.create(
		:name => "Gleason Ranch",
		:address => "",
		:phone => "7074770879",
		:state => "CA",
		:city => "Bodega, Sonoma",
		:zip => "94971",
		:has_csa => true,
		:delivers_butcher => true,  
		:delivers_drop => true,  # Let's set this to ~50 mi radius from "city center"? Translates to delivery cost estimate
		:delivers_host => false,  # Eliminates delivery cost estimate add-on
		:cow => true,
		:cow_live => 000,
		:cow_hanging => 3.25,
		:cow_fixed => 75,
		:pig => true,
		:pig_live => 000,
		:pig_hanging => 3.0,
		:pig_fixed => 60,
		:lamb => true,
		:lamb_live => 000,
		:lamb_hanging => 6.25,
		:lamb_fixed => 60,
		:goat => false,
		:user_id => gleason_user.id
	)
	gleason_user.update_attribute(:ranch_id, gleason_ranch.id)

	# These guys have veal!!
	godfrey_ranch = Ranch.create(
		:name => "Godfrey Family Farms",
		:address => "",
		:phone => "7074770879",
		:state => "CA",
		:city => "Meridian",
		:zip => "94971",
		:has_csa => true,
		:delivers_butcher => true,  
		:delivers_drop => true,  # Let's set this to ~50 mi radius from "city center"? Translates to delivery cost estimate
		:delivers_host => false,  # Eliminates delivery cost estimate add-on
		:pig => true,
		:pig_live => 000,
		:pig_hanging => 3.0, # Must be filled in. Pricing not accurate.
		:pig_fixed => 60, # Ditto
		:user_id => godfrey_user.id
	)
	godfrey_user.update_attribute(:ranch_id, godfrey_ranch.id)

	devils_gulch_ranch = Ranch.create(
		:name => "Devil's Gulch Ranch",
		:phone => "707-953-0923",
		:state => "CA",
		:city => "Marin",
		:zip => "94971",
		:has_csa => false,
		:preferred_butcher => buds_custom.id,
		:pig => true,
		:pig_hanging => 3.25,
		:pig_fixed => 00, 
		:lamb => true,
		:lamb_hanging => 4.00, #Fill in
		:lamb_fixed => 60, #Fill in
		:user_id => devils_gulch_user.id
	)
	devils_gulch_user.update_attribute(:ranch_id, devils_gulch_ranch.id)

# Hosts
	Host.delete_all
	klein = Host.create(
		:state => "CA",
		:phone => "later",
		:city => "San Francisco",
		:zip => "94114",
		:address => "3976 23rd St.",
		:user_id => niko.id
	)
	niko.update_attribute(:host_id, klein.id)

# Animals
	Animal.delete_all
	paul = Animal.create(
		:breed => "Black Angus", 
		:name => "Paul Ryan", 
		:photo => "Animals/PaulRyan.jpg", 
		:animal_type => "Cow",  
        :weight => 1216, 
        :ranch_id => miller_ranch.id, 
        :butcher_id => sanders.id,
        :host_id => klein.id,
        :no_sales => true,
        :opening_sale => false
	)

##################################################################################################################################
##################################################################################################################################

# Real Users (with orders)
Order.delete_all

	jasper = User.create(
		:name => "Jasper Sherman-Presser",
		:email => "jasper@meatup.in",
		:password => "password",
		:password_confirmation => "password",
		:zip => "94114"
	)

		jasper_1 = Order.create(
			:status => 2,
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

			jasper_1.update_attribute(:total, jasper_1.to_total)

	angelo = User.create(
		:name => "Angelo Maddox",
		:email => "angelo@meatup.in",
		:password => "password",
		:password_confirmation => "password",
		:zip => "94114"
	)
		angelo_1 = Order.create(
			:status => 2,
			:animal_id => paul.id,
			:user_id => angelo.id
		)
			Line.create(
				:order_id => angelo_1.id,
				:cut_id => sirloin.id,
				:notes => "Ground",
				:units => 11
			)
			Line.create(
				:order_id => angelo_1.id,
				:cut_id => ground.id,
				:units => 15
			)
			Line.create(
				:order_id => angelo_1.id,
				:cut_id => shank.id,
				:units => 2
			)
			Line.create(
				:order_id => angelo_1.id,
				:cut_id => offal.id,
				:units => 1
			)
			angelo_1.update_attribute(:total, angelo_1.to_total)

		angelo_2 = Order.create(
			:status => 2,
			:animal_id => paul.id,
			:user_id => angelo.id
		)
			Line.create(
				:order_id => angelo_2.id,
				:cut_id => porter.id,
				:units => 2
			)
			Line.create(
				:order_id => angelo_2.id,
				:cut_id => top.id,
				:units => 2
			)
			Line.create(
				:order_id => angelo_2.id,
				:cut_id => chuck.id,
				:units => 1
			)
			Line.create(
				:order_id => angelo_2.id,
				:cut_id => shank.id,
				:units => 2
			)
			Line.create(
				:order_id => angelo_2.id,
				:cut_id => offal.id,
				:units => 1
			)
			angelo_2.update_attribute(:total, angelo_2.to_total)

	thea = User.create(
		:name => "Thea Baumann",
		:email => "thea@meatup.in",
		:password => "password",
		:password_confirmation => "password",
		:zip => "94114"
	)
		thea_1 = Order.create(
			:status => 2,
			:animal_id => paul.id,
			:user_id => thea.id
		)
			Line.create(
				:order_id => thea_1.id,
				:cut_id => cross.id,
				:units => 3
			)
			Line.create(
				:order_id => thea_1.id,
				:cut_id => shank.id,
				:units => 3
			)
			Line.create(
				:order_id => thea_1.id,
				:cut_id => offal.id,
				:units => 2
			)
			Line.create(
				:order_id => thea_1.id,
				:cut_id => skirt.id,
				:units => 1
			)
			thea_1.update_attribute(:total, thea_1.to_total)

	pim = User.create(
		:name => "Pim Kyne",
		:email => "pim@meatup.in",
		:password => "password",
		:password_confirmation => "password",
		:zip => "94114"
	)
		pim_1 = Order.create(
			:status => 2,
			:animal_id => paul.id,
			:user_id => pim.id
		)
			Line.create(
				:order_id => pim_1.id,
				:cut_id => london.id,
				:units => 10
			)
			Line.create(
				:order_id => pim_1.id,
				:cut_id => ground.id,
				:units => 60
			)
			Line.create(
				:order_id => pim_1.id,
				:cut_id => stew.id,
				:units => 15
			)
			Line.create(
				:order_id => pim_1.id,
				:cut_id => chuck.id,
				:units => 2
			)
			Line.create(
				:order_id => pim_1.id,
				:cut_id => top.id,
				:units => 2
			)
			pim_1.update_attribute(:total, pim_1.to_total)
		pim_2 = Order.create(
			:status => 2,
			:animal_id => paul.id,
			:user_id => pim.id
		)
			Line.create(
				:order_id => pim_2.id,
				:cut_id => chuck.id,
				:units => 6
			)
			Line.create(
				:order_id => pim_2.id,
				:cut_id => eye.id,
				:units => 1
			)
			Line.create(
				:order_id => pim_2.id,
				:cut_id => bottom.id,
				:units => 2
			)
			Line.create(
				:order_id => pim_2.id,
				:cut_id => flank.id,
				:units => 2
			)
			pim_2.update_attribute(:total, pim_2.to_total)
			
	virginia = User.create(
		:name => "Virginia Woolworth",
		:email => "virginia@meatup.in",
		:password => "password",
		:password_confirmation => "password",
		:zip => "94114"
	)
		virginia_1 = Order.create(
			:status => 2,
			:animal_id => paul.id,
			:user_id => virginia.id
		)
			Line.create(
				:order_id => virginia_1.id,
				:cut_id => filet.id,
				:units => 2
			)
			virginia_1.update_attribute(:total, virginia_1.to_total)

	andrea = User.create(
		:name => "Andrea Woodside",
		:email => "andrea@meatup.in",
		:password => "password",
		:password_confirmation => "password",
		:zip => "94114"
	)
		andrea_1 = Order.create(
			:status => 2,
			:animal_id => paul.id,
			:user_id => andrea.id
		)
			Line.create(
				:order_id => andrea_1.id,
				:cut_id => sirloin.id,
				:units => 1
			)
			andrea_1.update_attribute(:total, andrea_1.to_total)

	james = User.create(
		:name => "James Ruggiero",
		:email => "james@meatup.in",
		:password => "password",
		:password_confirmation => "password",
		:zip => "94114"
	)
		james_1 = Order.create(
			:status => 2,
			:animal_id => paul.id,
			:user_id => james.id
		)
			Line.create(
				:order_id => james_1.id,
				:cut_id => eye.id,
				:units => 1
			)
			Line.create(
				:order_id => james_1.id,
				:cut_id => chuck.id,
				:units => 1
			)
			Line.create(
				:order_id => james_1.id,
				:cut_id => offal.id,
				:units => 1
			)
			james_1.update_attribute(:total, james_1.to_total)

	maura = User.create(
		:name => "Maura Thompson",
		:email => "maura@meatup.in",
		:password => "password",
		:password_confirmation => "password",
		:zip => "94114"
	)
		maura_1 = Order.create(
			:status => 2,
			:animal_id => paul.id,
			:user_id => maura.id
		)
			Line.create(
				:order_id => maura_1.id,
				:cut_id => stew.id,
				:units => 2
			)
			Line.create(
				:order_id => maura_1.id,
				:cut_id => brisket.id,
				:units => 1
			)
			Line.create(
				:order_id => maura_1.id,
				:cut_id => ground.id,
				:units => 2
			)
			Line.create(
				:order_id => maura_1.id,
				:cut_id => top.id,
				:units => 1
			)
			maura_1.update_attribute(:total, maura_1.to_total)

		sasha_1 = Order.create(
			:status => 2,
			:animal_id => paul.id,
			:user_id => sasha.id
		)
			Line.create(
				:order_id => sasha_1.id,
				:cut_id => flap.id,
				:units => 2
			)
			Line.create(
				:order_id => sasha_1.id,
				:cut_id => ground.id,
				:units => 2
			)
			Line.create(
				:order_id => sasha_1.id,
				:cut_id => porter.id,
				:units => 3
			)
			Line.create(
				:order_id => sasha_1.id,
				:cut_id => ribeye.id,
				:units => 3
			)
			Line.create(
				:order_id => sasha_1.id,
				:cut_id => neck.id,
				:units => 4
			)
			Line.create(
				:order_id => sasha_1.id,
				:cut_id => cross.id,
				:units => 4
			)
			Line.create(
				:order_id => sasha_1.id,
				:cut_id => offal.id,
				:units => 1
			)
			Line.create(
				:order_id => sasha_1.id,
				:cut_id => t.id,
				:units => 3
			)
			Line.create(
				:order_id => sasha_1.id,
				:cut_id => stew.id,
				:units => 1
			)
			Line.create(
				:order_id => sasha_1.id,
				:cut_id => shank.id,
				:units => 1
			)
			Line.create(
				:order_id => sasha_1.id,
				:cut_id => fat.id,
				:units => 1
			)
			Line.create(
				:order_id => sasha_1.id,
				:cut_id => top.id,
				:units => 1
			)
			Line.create(
				:order_id => sasha_1.id,
				:cut_id => rump.id,
				:units => 1
			)
			sasha_1.update_attribute(:total, sasha_1.to_total)

	loren = User.create(
		:name => "Loren Kwan",
		:email => "loren@meatup.in",
		:password => "password",
		:password_confirmation => "password",
		:zip => "94114"
	)
		loren_1 = Order.create(
			:status => 2,
			:animal_id => paul.id,
			:user_id => loren.id
		)
			Line.create(
				:order_id => loren_1.id,
				:cut_id => skirt.id,
				:units => 1
			)
			Line.create(
				:order_id => loren_1.id,
				:cut_id => offal.id,
				:units => 1
			)
			loren_1.update_attribute(:total, loren_1.to_total)

		loren_2 = Order.create(
			:status => 2,
			:animal_id => paul.id,
			:user_id => loren.id
		)
			Line.create(
				:order_id => loren_2.id,
				:cut_id => ground.id,
				:units => 1
			)
			Line.create(
				:order_id => loren_2.id,
				:cut_id => tri.id,
				:units => 1
			)
			loren_2.update_attribute(:total, loren_2.to_total)
	vincent = User.create(
		:name => "Vincent Casotti",
		:email => "vincent@meatup.in",
		:password => "password",
		:password_confirmation => "password",
		:zip => "94114"
	)
		vincent_1 = Order.create(
			:status => 2,
			:animal_id => paul.id,
			:user_id => vincent.id
		)
			Line.create(
				:order_id => vincent_1.id,
				:cut_id => ground.id,
				:units => 2
			)
			Line.create(
				:order_id => vincent_1.id,
				:cut_id => stew.id,
				:units => 1
			)
			Line.create(
				:order_id => vincent_1.id,
				:cut_id => ribeye.id,
				:units => 1
			)
			Line.create(
				:order_id => vincent_1.id,
				:cut_id => t.id,
				:units => 1
			)
			vincent_1.update_attribute(:total, vincent_1.to_total)

	amy = User.create(
		:name => "Amy Lin",
		:email => "amy@meatup.in",
		:password => "password",
		:password_confirmation => "password",
		:zip => "94114"
	)
		amy_1 = Order.create(
			:status => 2,
			:animal_id => paul.id,
			:user_id => amy.id
		)
			Line.create(
				:order_id => amy_1.id,
				:cut_id => top.id,
				:units => 1
			)
			amy_1.update_attribute(:total, amy_1.to_total)

	lyra = User.create(
		:name => "Lyra Levin",
		:email => "lyra@meatup.in",
		:password => "password",
		:password_confirmation => "password",
		:zip => "94114"
	)
		lyra_1 = Order.create(
			:status => 2,
			:animal_id => paul.id,
			:user_id => lyra.id
		)
			Line.create(
				:order_id => lyra_1.id,
				:cut_id => ground.id,
				:units => 2
			)
			Line.create(
				:order_id => lyra_1.id,
				:cut_id => stew.id,
				:units => 1
			)
			Line.create(
				:order_id => lyra_1.id,
				:cut_id => top.id,
				:units => 1
			)
			Line.create(
				:order_id => lyra_1.id,
				:cut_id => offal.id,
				:units => 2
			)
			lyra_1.update_attribute(:total, lyra_1.to_total)

	ted = User.create(
		:name => "Ted Blackman",
		:email => "ted@meatup.in",
		:password => "password",
		:password_confirmation => "password",
		:zip => "94114"
	)
		ted_1 = Order.create(
			:status => 2,
			:animal_id => paul.id,
			:user_id => ted.id
		)
			Line.create(
				:order_id => ted_1.id,
				:cut_id => stew.id,
				:units => 1
			)
			ted_1.update_attribute(:total, ted_1.to_total)

	eli = User.create(
		:name => "Eli Scott",
		:email => "eli@meatup.in",
		:password => "password",
		:password_confirmation => "password",
		:zip => "94114"
	)
		eli_1 = Order.create(
			:status => 2,
			:animal_id => paul.id,
			:user_id => eli.id
		) 
			Line.create(
				:order_id => eli_1.id,
				:cut_id => ribeye.id,
				:units => 1
			)
			eli_1.update_attribute(:total, eli_1.to_total)

	ashley = User.create(
		:name => "Ashley Meyer",
		:email => "ashley@meatup.in",
		:password => "password",
		:password_confirmation => "password",
		:zip => "94114"
	)
		ashley_1 = Order.create(
			:status => 2,
			:animal_id => paul.id,
			:user_id => ashley.id
		) 
			Line.create(
				:order_id => ashley_1.id,
				:cut_id => ground.id,
				:units => 1
			)
			Line.create(
				:order_id => ashley_1.id,
				:cut_id => skirt.id,
				:units => 1
			)
			ashley_1.update_attribute(:total, ashley_1.to_total)

	laura = User.create(
		:name => "Laura Spiekerman",
		:email => "laura@meatup.in",
		:password => "password",
		:password_confirmation => "password",
		:zip => "94114"
	)
		laura_1 = Order.create(
			:status => 2,
			:animal_id => paul.id,
			:user_id => laura.id
		) 
			Line.create(
				:order_id => laura_1.id,
				:cut_id => brisket.id,
				:units => 1
			)
			Line.create(
				:order_id => laura_1.id,
				:cut_id => short.id,
				:units => 2
			)
			Line.create(
				:order_id => laura_1.id,
				:cut_id => porter.id,
				:units => 1
			)
			Line.create(
				:order_id => laura_1.id,
				:cut_id => ribeye.id,
				:units => 1
			)
			Line.create(
				:order_id => laura_1.id,
				:cut_id => skirt.id,
				:units => 1
			)
			Line.create(
				:order_id => laura_1.id,
				:cut_id => ground.id,
				:units => 3
			)
			laura_1.update_attribute(:total, laura_1.to_total)
