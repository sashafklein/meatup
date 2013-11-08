begin

# Cuts
	@log = ["Starting..."]

	# The Real Paul Ryan
	london = Cut.create!(
			animal_type: "cow",
			name: "London Broil",
	  	price: 4,
	  	package_weight: 2,
	  	percent: 1.67,
	  	comp: 7.99,
	  	savings: 50,
	  	prep_options: "grind stew", 
	  	description: "'London Broil' was first a preparation technique, but became the name for the two cuts -- Flank and, increasingly, Top Round -- that the technique applied to."
  	)
	ground = Cut.create!(
			animal_type: "cow",
			name: "Ground Beef",
	  	price: 2.63,
	  	package_weight: 1,
	  	percent: 7.67,
	  	comp: 6.99,
	  	savings: 62,
	  	description: "Burgers, meatballs, meatloaf and beef moussaka."
  	) 
  	stew = Cut.create!(
			animal_type: "cow",
			name: "Beef Stew",
	  	price: 2.78,
	  	package_weight: 2.22,
	  	percent: 4.25,
	  	comp: 7.99,
	  	savings: 65,
	  	prep_options: "grind", 
	  	description: "Tagine, bourgignon, pot au feu, chili, and a good old fashioned beef stew."
  	)
  	brisket = Cut.create!(
			animal_type: "cow",
			name: "Brisket",
	  	price: 5.35,
	  	package_weight: 4,
	  	percent: 0.67,
	  	comp: 8.99,
	  	savings: 40,
	  	description: "The classic roasting/braising/BBQ/Passover cut from just below the chuck at the front of the animal."
  	)
  	cross = Cut.create!(
			animal_type: "cow",
			name: "Cross Rib",
	  	price: 4.5,
	  	package_weight: 3.38,
	  	percent: 2.25,
	  	comp: 7.99,
	  	savings: 44,
	  	incentive: true,
	  	prep_options: "grind stew", 
	  	description: "Similar to the Chuck Roast, a braiser or roaster. Cook long and low."
  	)
  	rump = Cut.create!(
			animal_type: "cow",
			name: "Rump Steak",
	  	price: 5.55,
	  	package_weight: 3.5,
	  	percent: 0.58,
	  	comp: 8.99,
	  	savings: 38,
	  	prep_options: "grind stew", 
	  	description: "One of Argentina/Brazil's favorites, less known in the states. Great flavor with a nice thick layer of fat. A crazy deal."
  	)
  	short = Cut.create!(
			animal_type: "cow",
			name: "Short Ribs",
	  	price: 5.55,
	  	package_weight: 3.33,
	  	percent: 1.67,
	  	comp: 8.99,
	  	savings: 38,
	  	prep_options: 'debone', 
	  	description: "A braising staple from the lower portions of the ribs. Undercook and they'll be unpleasantly chewy. Stew low and long to soften and release flavors."
  	)
  	eye = Cut.create!(
			animal_type: "cow",
			name: "Eye of Round",
	  	price: 5.25,
	  	package_weight: 3.50,
	  	percent: 0.58,
	  	comp: 9.99,
	  	savings: 47,
	  	prep_options: "grind stew", 
	  	description: "A lean but relatively tender cut, the eye of the round is good for rare grilling or delicate braising."
  	)
  	bottom = Cut.create!(
			animal_type: "cow",
			name: "Bottom Round",
	  	price: 6.55,
	  	package_weight: 4,
	  	percent: 0.67,
	  	comp: 8.99,
	  	savings: 27,
	  	incentive: true,
	  	prep_options: "grind stew", 
	  	description: "A lean cut from the outer leg. Stew/braise for a while or grind up."
  	)
  	tri = Cut.create!(
			animal_type: "cow",
			name: "Tri Tip",
	  	price: 8.1,
	  	package_weight: 2,
	  	percent: 0.67,
	  	comp: 9.99,
	  	savings: 19, 
	  	description: "An increasingly popular cut (in SF particularly), for its rich flavor and thick layer of fat."
  	)
  	flank = Cut.create!(
			animal_type: "cow",
			name: "Flank",
	  	price: 5.55,
	  	package_weight: 1.5,
	  	percent: 0.25,
	  	comp: 11.99,
	  	savings: 54, 
	  	description: "A thin, tender, and (pleasantly) chewy steak from the abdomen. A favorite for marinated grilling."
  	)
  	chuck = Cut.create!(
			animal_type: "cow",
			name: "Chuck Roast",
	  	price: 7.6,
	  	package_weight: 3.9,
	  	percent: 3.25,
	  	comp: 9.99,
	  	savings: 24,
	  	prep_options: "grind stew", 
	  	description: "A well-marbled, rich piece of steak best for braising and roasts (but also not bad in steaks)."
  	)
  	hanger = Cut.create!(
			animal_type: "cow",
			name: "Hanger Steak",
	  	price: 7.8,
	  	package_weight: 1.2,
	  	percent: 0,
	  	comp: 10.99,
	  	savings: 0, 
	  	description: "Used to be called the Butcher's Cut, because butchers would keep it for themselves. One of the most flavorful cuts for grilling/searing. From the inner skirt."
  	)
  	flat = Cut.create!(
			animal_type: "cow",
			name: "Flat Iron",
	  	price: 8.15,
	  	package_weight: 1,
	  	percent: 0,
	  	comp: 13.99,
	  	savings: 0, 
	  	description: "An increasingly popular cut for grilling or roasting. From the shoulder."
  	)
  	top = Cut.create!(
			animal_type: "cow",
			name: "Top Sirloin Steak",
	  	price: 10.9,
	  	package_weight: 1.56,
	  	percent: 1.17,
	  	comp: 11.99,
	  	savings: 9,
	  	prep_options: "grind stew",
	  	description: "Bread-and-butter grilling cut, with a nice cap of fat."
  	)
  	skirt = Cut.create!(
			animal_type: "cow",
			name: "Skirt",
	  	price: 13.2,
	  	package_weight: 1.25,
	  	percent: 0.42,
	  	comp: 14.99,
	  	savings: 12, 
	  	description: "This thin cut from the inner 'plate' is both chewy and tender."
  	)
  	porter = Cut.create!(
			animal_type: "cow",
			name: "Porterhouse",
	  	price: 13.05,
	  	package_weight: 2.6,
	  	percent: 2.78,
	  	comp: 17.99,
	  	savings: 27,
	  	prep_options: 'debone', 
	  	description: "A rich and satisfying steakhouse classic, from the short loin, in the lower ribs. A balance of sirloin steak and tenderloin, separated by a bone."
  	)
  	t = Cut.create!(
			animal_type: "cow",
			name: "T-Bone",
	  	price: 15.05,
	  	package_weight: 2,
	  	percent: 1.17,
	  	comp: 16.99,
	  	savings: 11, 
	  	description: "Another delicious two-part grilling/roasting cut, with Tenderloin and NY Strip on either side of a T Bone"
  	)
  	ribeye = Cut.create!(
			animal_type: "cow",
			name: "Ribeye",
	  	price: 15.75,
	  	package_weight: 2,
	  	percent: 1.83,
	  	comp: 20.99,
	  	savings: 25,
	  	prep_options: 'debone', 
	  	description: "An obscenely delicious steak cut from the upper ribs. Pan sear one of these and throw it in the oven for a handful of minutes."
  	)
  	ny = Cut.create!(
			animal_type: "cow",
			name: "NY Strip",
	  	price: 15.7,
	  	package_weight: 1,
	  	percent: 0,
	  	comp: 19.99,
	  	savings: 0, 
	  	description: "Can't be blank"
  	)
  	filet = Cut.create!(
			animal_type: "cow",
			name: "Filet Mignon Tenderloin",
	  	price: 20,
	  	package_weight: 1.5,
	  	percent: 0.25,
	  	comp: 29.99,
	  	savings: 33, 
	  	description: "A muscle that does very little work, tenderloin is an extremely tender steak. Sear briefly."
  	)
  	sirloin = Cut.create!(
			animal_type: "cow",
			name: "Sirloin Tip",
	  	price: 8.1,
	  	package_weight: 1.1,
	  	percent: 1.99,
	  	comp: 9.99,
	  	savings: 19,
	  	prep_options: "grind stew", 
	  	description: "Peeled off the top sirloin, this cut is great for cooking quick and high."
  	)
  	shank = Cut.create!(
			animal_type: "cow",
			name: "Shank",
	  	price: 3,
	  	package_weight: 2.64,
	  	percent: 2.42,
	  	comp: 3,
	  	savings: 0,
	  	prep_options: 'debone',
	  	prep_options: "grind stew", 
	  	description: "A ring off of the weight-bearing front or back legs, these shanks are great for stews and braises, and come with a marrow bone."
  	)
  	knuckle = Cut.create!(
			animal_type: "cow",
			name: "Bones",
	  	price: 3,
	  	package_weight: 1.84,
	  	percent: 0.61,
	  	comp: 3,
	  	savings: 0,
	  	incentive: true, 
	  	description: "Beef bones, full of flavor. Just roast these for a few minutes to darken them, and throw them in a soup."
  	)
  	fat = Cut.create!(
			animal_type: "cow",
			name: "Suet Fat",
	  	price: 3,
	  	package_weight: 1.8,
	  	percent: 0.4,
	  	comp: 3,
	  	savings: 0,
	  	incentive: true, 
	  	description: "Rich, pure suet fat from around the kidneys. Rendered, this makes great cooking fat, with its rich taste and high smoke point."
  	)
  	kidney = Cut.create!(
			animal_type: "cow",
			name: "Kidney",
	  	price: 3,
	  	package_weight: 2,
	  	percent: 0.17,
	  	comp: 3,
	  	savings: 0,
	  	incentive: true, 
	  	description: "Dense and flavorful, sear these up quickly or throw them in a rich stew."
  	)
  	offal = Cut.create!(
		animal_type: "cow",
		name: "Offal",
	  	price: 3,
	  	package_weight: 1.31,
	  	percent: 1.42,
	  	comp: 3,
	  	savings: 0,
	  	incentive: true, 
	  	description: "Heart, tongue, cheek, and everyone's favorite, liver."
  	)
  	flap = Cut.create!(
		animal_type: "cow",
		name: "Flap Meat",
	  	price: 3,
	  	package_weight: 1.5,
	  	percent: 0.50,
	  	comp: 3,
	  	savings: 0,
	  	incentive: true, 
	  	description: "From stringy diaphrams throughout the cow, this layered meat is chewy as hell when undercooked, but becomes unbelievably moist and soft when slow-roasted."
  	)
  	neck = Cut.create!(
		animal_type: "cow",
		name: "Neck",
	  	price: 3,
	  	package_weight: 4.75,
	  	percent: 1.58,
	  	comp: 3,
	  	savings: 0, 
	  	description: "Thick, chewy, and meaty, the neck meat radiates out from the neckbone and is great for longs braises or barbecues."
  	)

  	#The Real Donald Trump
   # 	suet = Cut.create!(
		 # 	animal_type: "pig",
		 # 	name: "Bacon",
	  #  	price: 7,
	  #  	package_weight: 1,
	  #  	percent: 3,
	  #  	comp: 1, 
	  #  	savings: 0, 
	  #  	description: "Yum."
  	# )
		leaf = Cut.create!(
			animal_type: "pig",
			name: "Leaf Lard",
			package_weight: 1.94,
	  	percent: 3,
	  	price: 2,
	  	comp: 6, 
	  	savings: 67, 
	  	description: "Fat from around the kidneys, leaf lard (the equivalent of beef/mutton suet) is clean tasting and great for frying and even baking."
  	)
  	leg_steak = Cut.create!(
			animal_type: "pig",
			name: "Fresh Ham Steak",
			package_weight: 3.97,
	  	percent: 9.52,
	  	price: 5.2,
	  	comp: 6, 
	  	savings: 67, 
	  	description: "Fat from around the kidneys, leaf lard (the equivalent of beef/mutton suet) is clean tasting and great for frying and even baking."
  	) 
  	Cut.create!(
			animal_type: "pig",
			name: "Bacon",
	  	price: 7,
	  	package_weight: 1,
	  	percent: 3,
	  	comp: 1, 
	  	savings: 0, 
	  	description: "Yum."
  	)
  	Cut.create!(
			animal_type: "pig",
			name: "Pork Chop",
	  	price: 10,
	  	package_weight: 2,
	  	percent: 5, 
	  	comp: 14, 
	  	savings: 0,
	  	description: "Can't be blank"
  	)

  	# Other Cuts

  	Cut.create!(
			animal_type: "goat",
			name: "goat Stew",
	  	price: 7,
	  	package_weight: 2,
	  	percent: 3, 
	  	description: "Can't be blank"
  	)

# Users
@log << "Seeded Cuts"

	sasha = User.create!(
		name: "Sasha Klein",
		email: "sashaklein1@gmail.com",
		password: "password",
		password_confirmation: "password",
		zip: "94114"
	)
	sasha.toggle!(:admin)
	niko = User.create!(
		name: "Niko Klein",
		email: "niko@meatup.in",
		password: "password",
		password_confirmation: "password",
		zip: "94114", 
		is_host: true
	)
	two = User.create!(
		name: "Two",
		email: "two@meatup.in",
		password: "password",
		password_confirmation: "password",
		zip: "94114"
	)
	miller_ranch_user = User.create!(
		name: "Miler Ranch",
		email: "miller_ranch@meatup.in",
		password: "password",
		password_confirmation: "password",
		zip: "94114",
		is_rancher: true
	)
	clark_summit_user = User.create!(
		name: "Clark Summit Farm",
		email: "clark_summit@meatup.in",
		password: "password",
		password_confirmation: "password",
		zip: "94114", 
		is_rancher: true
	)
	sanders_user = User.create!(
		name: "Sanders Butcher Person",
		email: "sanders@meatup.in",
		password: "password",
		password_confirmation: "password",
		zip: "94114",
		is_butcher: true
	)
	buds_custom_user = User.create!(
		name: "Buds Custom Meats",
		email: "buds_custom@meatup.in",
		password: "password",
		password_confirmation: "password",
		zip: "94114", 
		is_butcher: true
	)
	gleason_user = User.create!(
		name: "Nancy",
		email: "infoatgleasonranch@meatup.in",
		password: "password",
		password_confirmation: "password",
		zip: "94114", 
		is_butcher: true,
		is_rancher: true
	)
	godfrey_user = User.create!(
		name: "Godfrey",
		email: "speechatthespeechworks@meatup.in",
		password: "password",
		password_confirmation: "password",
		zip: "94114", 
		is_rancher: true
	)
	devils_gulch_user = User.create!(
		name: "Mark Pasternak",
		email: "markatdevilsgulchranch@meatup.in",
		password: "password",
		password_confirmation: "password",
		zip: "94114",
		is_rancher: true
	)

# Butchers
@log << "Seeded Users"

	sanders = Butcher.create!(
		name: "Sanders Meat Co",
		address: "Turlock St.",
		city: "Turlock",
		state: "CA",
		zip: "94114",
		phone: "999-999-9999",
		hanging_price: 0.55,
		final_price: 0,
		wrap_price: 0,
		vacuum_price: 0.00,
		ground: true,
		stew: true,
		boneless: true,
		user_id: sanders_user.id,
	)
	sanders_user.update_attribute(:butcher_id, sanders.id)

	buds_custom = Butcher.create!(
		name: "Bud's Custom Meats",
		address: "Turlock St.",
		city: "Turlock",
		state: "CA",
		zip: "94114",
		phone: "999-999-9999",
		hanging_price: 0.80,
		final_price: 0,
		wrap_price: 0,
		vacuum_price: 0.00,
		ground: true,
		stew: true,
		boneless: true,
		user_id: buds_custom_user.id
	)
	buds_custom_user.update_attribute(:butcher_id, buds_custom.id)

	gleason_butcher = Butcher.create!(
		name: "FIX NAME",
		address: "Turlock St.",
		city: "Turlock",
		state: "CA",
		zip: "94114",
		phone: "999-999-9999",
		hanging_price: 0.75,
		final_price: 0,
		wrap_price: 0,
		vacuum_price: 0.00,
		ground: true,
		stew: true,
		boneless: true,
		user_id: gleason_user.id,
	)
	gleason_user.update_attribute(:butcher_id, gleason_butcher.id)

# Ranches
@log << "Seeded Butchers"


	# blank_ranch = Ranch.create!(
	# 	name: "Blank",
	# 	address: "Address",
	# 	phone: "Number",
	# 	state: "CA",
	# 	city: "Tomales",
	# 	zip: "94971",
	# 	has_csa: true,
	# 	delivers_butcher: true,  
	# 	delivers_drop: true,  # Let's set this to ~50 mi radius from "city center"? Translates to delivery cost estimate
	# 	delivers_host: true,  # Eliminates delivery cost estimate add-on
	# 	preferred_butcher: blank_butcher.id,
	# 	user_id: blank_ranch_user.id
	# )

	miller_ranch = Ranch.create!(
		user_id: miller_ranch_user.id,
		name: "Miller Ranch",
		address: "Ranch Road",
		phone: "999-999-9999",
		state: "CA",
		city: "Oakdale",
		zip: "94114",
		has_csa: true,
		preferred_butcher: sanders.id,
		delivers_butcher: true,
		delivers_drop: true,
		delivers_host: false
	)
	miller_ranch_user.update_attribute(:ranch_id, miller_ranch.id)
	@log << "< Miller Ranch seeded"
		
		miller_cow = RanchAnimal.create!(
			ranch_id: miller_ranch.id,
			animal_type: "cow",
			live_price: 1.40
		)
		@log << "< - Miller cow seeded"

	clark_summit = Ranch.create!(
		name: "Clark Summit Farm",
		address: "30201 Shoreline Highway",
		phone: "707-876-3516",
		state: "CA",
		city: "Tomales",
		zip: "94971",
		has_csa: true,
		delivers_butcher: true,
		delivers_drop: false,
		delivers_host: true,
		user_id: clark_summit_user.id
	)
	clark_summit_user.update_attribute(:ranch_id, clark_summit.id)
	@log << "< Clark Summit seeded"

		clark_cow = RanchAnimal.create!(
			ranch_id: clark_summit.id,
			animal_type: "cow",
			hanging_price: 3.75,
			fixed_cost: 100
		)
		clark_pig = RanchAnimal.create!(
			ranch_id: clark_summit.id,
			animal_type: "pig",
			hanging_price: 4,
			fixed_cost: 60
		)
		@log << "< - Clark Summit animals seeded"

	gleason_ranch = Ranch.create!(
		name: "Gleason Ranch",
		address: "fake",
		phone: "7074770879",
		state: "CA",
		city: "Bodega, Sonoma",
		zip: "94971",
		has_csa: true,
		delivers_butcher: true,  
		delivers_drop: true,  # Let's set this to ~50 mi radius from "city center"? Translates to delivery cost estimate
		delivers_host: false,  # Eliminates delivery cost estimate add-on
		user_id: gleason_user.id
	)
	gleason_user.update_attribute(:ranch_id, gleason_ranch.id)
	@log << "< Gleason Ranch seeded"
		
		gleason_ranch.ranch_animals.create!(
			animal_type: "cow",
			hanging_price: 3.25,
			fixed_cost: 75
		)
		gleason_ranch.ranch_animals.create!(
			animal_type: "pig",
			hanging_price: 3,
			fixed_cost: 60
		)
		gleason_ranch.ranch_animals.create!(
			animal_type: "cow",
			hanging_price: 6.25,
			fixed_cost: 60
		)
		@log << "< - Gleason Ranch animals seeded"

	# These guys have veal!!
	godfrey_ranch = Ranch.create!(
		name: "Godfrey Family Farms",
		address: "can't be blank",
		phone: "7074770879",
		state: "CA",
		city: "Meridian",
		zip: "94971",
		has_csa: true,
		delivers_butcher: true,  
		delivers_drop: true,  # Let's set this to ~50 mi radius from "city center"? Translates to delivery cost estimate
		delivers_host: false,  # Eliminates delivery cost estimate add-on
		user_id: godfrey_user.id
	)
	godfrey_user.update_attribute(:ranch_id, godfrey_ranch.id)
	@log << "Godfrey Farms seeded"

		godfrey_ranch.ranch_animals.create!(
			animal_type: "pig",
			hanging_price: 3,
			fixed_cost: 60
		)
		@log << "< - Godfrey Farms pig seeded"

	devils_gulch_ranch = Ranch.create!(
		name: "Devil's Gulch Ranch",
		address: "fake address",
		phone: "707-953-0923",
		state: "CA",
		city: "Marin",
		zip: "94971",
		has_csa: false,
		preferred_butcher: buds_custom.id,
		user_id: devils_gulch_user.id
	)
	devils_gulch_user.update_attribute(:ranch_id, devils_gulch_ranch.id)
	@log << "< Devil's Gulch seeded"

		devils_gulch_ranch.ranch_animals.create!(
			animal_type: "pig",
			hanging_price: 3.25
		)
		devils_gulch_ranch.ranch_animals.create!(
			animal_type: "lamb",
			hanging_price: 4,
			fixed_cost: 60
		)
		@log << "< - Devil's Gulch animals seeded"
# Hosts
@log << "Seeded Ranches"

	klein = Host.create!(
		state: "CA",
		phone: "later",
		city: "San Francisco",
		zip: "94114",
		address: "3976 23rd St.",
		user_id: niko.id
	)
	niko.update_attribute(:host_id, klein.id)

# Animals
@log << "Seeded Hosts"

	paul = Animal.create!(
		breed: "Black Angus", 
		name: "Paul Ryan", 
		photo: "Animals/PaulRyan.jpg", 
		animal_type: "cow",  
    weight: 1216, 
    ranch_id: miller_ranch.id, 
    butcher_id: sanders.id,
    host_id: klein.id,
    no_sales: true,
    conduct_opening_sale: false
	)
	@log << "Paul seeded"

	donald = Animal.create!(
		breed: "Herfordshire", 
		name: "Donald Trump", 
		animal_type: "pig",  
    weight: 600, 
    ranch_id: devils_gulch_ranch.id, 
    butcher_id: buds_custom.id,
    host_id: klein.id,
    no_sales: true,
    conduct_opening_sale: false
	)
	@log << "Donald seeded"

##################################################################################################################################
##################################################################################################################################

# Real Users (with orders)
@log << "Seeded Animals"

	jasper = User.create!(
		name: "Jasper Sherman-Presser",
		email: "jasper@meatup.in",
		password: "password",
		password_confirmation: "password",
		zip: "94114"
	)

		jasper_1 = Order.create!(
			status: 2,
			animal_id: paul.id,
			user_id: jasper.id
		)
		real_cut = RealCut.find_by_cut_id_and_animal_id(stew.id, paul.id)
			Line.create!(
				order_id: jasper_1.id,
				real_cut_id: real_cut.id,
				units: 2,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(ribeye.id, paul.id)
			Line.create!(
				order_id: jasper_1.id,
				real_cut_id: real_cut.id,
				units: 1,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(ground.id, paul.id)
			Line.create!(
				order_id: jasper_1.id,
				real_cut_id: real_cut.id,
				units: 4,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(sirloin.id, paul.id)
			Line.create!(
				order_id: jasper_1.id,
				real_cut_id: real_cut.id,
				units: 2,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(short.id, paul.id)
			Line.create!(
				order_id: jasper_1.id,
				real_cut_id: real_cut.id,
				units: 1,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(top.id, paul.id)
			Line.create!(
				order_id: jasper_1.id,
				real_cut_id: real_cut.id,
				units: 1,
				sale_price: real_cut.flat_price
			)

			jasper_1.update_attribute(:total, jasper_1.to_total)
			@log << "< Jasper done"

	angelo = User.create!(
		name: "Angelo Maddox",
		email: "angelo@meatup.in",
		password: "password",
		password_confirmation: "password",
		zip: "94114"
	)
		angelo_1 = Order.create!(
			status: 2,
			animal_id: paul.id,
			user_id: angelo.id
		)
		real_cut = RealCut.find_by_cut_id_and_animal_id(sirloin.id, paul.id)
			Line.create!(
				order_id: angelo_1.id,
				real_cut_id: real_cut.id,
				notes: "Ground",
				sale_price: real_cut.flat_price,
				units: 11
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(ground.id, paul.id)
			Line.create!(
				order_id: angelo_1.id,
				real_cut_id: real_cut.id,
				units: 15,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(shank.id, paul.id)
			Line.create!(
				order_id: angelo_1.id,
				real_cut_id: real_cut.id,
				units: 2,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(offal.id, paul.id)
			Line.create!(
				order_id: angelo_1.id,
				real_cut_id: real_cut.id,
				units: 1,
				sale_price: real_cut.flat_price
			)
			angelo_1.update_attribute(:total, angelo_1.to_total)

		angelo_2 = Order.create!(
			status: 2,
			animal_id: paul.id,
			user_id: angelo.id
		)
		real_cut = RealCut.find_by_cut_id_and_animal_id(porter.id, paul.id)
			Line.create!(
				order_id: angelo_2.id,
				real_cut_id: real_cut.id,
				units: 2,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(top.id, paul.id)
			Line.create!(
				order_id: angelo_2.id,
				real_cut_id: real_cut.id,
				units: 2,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(chuck.id, paul.id)
			Line.create!(
				order_id: angelo_2.id,
				real_cut_id: real_cut.id,
				units: 1,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(shank.id, paul.id)
			Line.create!(
				order_id: angelo_2.id,
				real_cut_id: real_cut.id,
				units: 2,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(offal.id, paul.id)
			Line.create!(
				order_id: angelo_2.id,
				real_cut_id: real_cut.id,
				units: 1,
				sale_price: real_cut.flat_price
			)
			angelo_2.update_attribute(:total, angelo_2.to_total)
			@log << "< Angelo 1 & 2 done"

	thea = User.create!(
		name: "Thea Baumann",
		email: "thea@meatup.in",
		password: "password",
		password_confirmation: "password",
		zip: "94114"
	)
		thea_1 = Order.create!(
			status: 2,
			animal_id: paul.id,
			user_id: thea.id
		)
		real_cut = RealCut.find_by_cut_id_and_animal_id(cross.id, paul.id)
			Line.create!(
				order_id: thea_1.id,
				real_cut_id: real_cut.id,
				units: 3,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(shank.id, paul.id)
			Line.create!(
				order_id: thea_1.id,
				real_cut_id: real_cut.id,
				units: 3,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(offal.id, paul.id)
			Line.create!(
				order_id: thea_1.id,
				real_cut_id: real_cut.id,
				units: 2,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(skirt.id, paul.id)
			Line.create!(
				order_id: thea_1.id,
				real_cut_id: real_cut.id,
				units: 1,
				sale_price: real_cut.flat_price
			)
			thea_1.update_attribute(:total, thea_1.to_total)
			@log << "< Thea done"

	pim = User.create!(
		name: "Pim Kyne",
		email: "pim@meatup.in",
		password: "password",
		password_confirmation: "password",
		zip: "94114"
	)
		pim_1 = Order.create!(
			status: 2,
			animal_id: paul.id,
			user_id: pim.id
		)
		real_cut = RealCut.find_by_cut_id_and_animal_id(london.id, paul.id)
			Line.create!(
				order_id: pim_1.id,
				real_cut_id: real_cut.id,
				units: 10,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(ground.id, paul.id)
			Line.create!(
				order_id: pim_1.id,
				real_cut_id: real_cut.id,
				units: 60,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(stew.id, paul.id)
			Line.create!(
				order_id: pim_1.id,
				real_cut_id: real_cut.id,
				units: 15,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(chuck.id, paul.id)
			Line.create!(
				order_id: pim_1.id,
				real_cut_id: real_cut.id,
				units: 2,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(top.id, paul.id)
			Line.create!(
				order_id: pim_1.id,
				real_cut_id: real_cut.id,
				units: 2,
				sale_price: real_cut.flat_price
			)
			pim_1.update_attribute(:total, pim_1.to_total)
		pim_2 = Order.create!(
			status: 2,
			animal_id: paul.id,
			user_id: pim.id
		)
		real_cut = RealCut.find_by_cut_id_and_animal_id(chuck.id, paul.id)
			Line.create!(
				order_id: pim_2.id,
				real_cut_id: real_cut.id,
				units: 6,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(eye.id, paul.id)
			Line.create!(
				order_id: pim_2.id,
				real_cut_id: real_cut.id,
				units: 1,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(bottom.id, paul.id)
			Line.create!(
				order_id: pim_2.id,
				real_cut_id: real_cut.id,
				units: 2,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(flank.id, paul.id)
			Line.create!(
				order_id: pim_2.id,
				real_cut_id: real_cut.id,
				units: 2,
				sale_price: real_cut.flat_price
			)
			pim_2.update_attribute(:total, pim_2.to_total)
			@log << "< Pim done"
			
	virginia = User.create!(
		name: "Virginia Woolworth",
		email: "virginia@meatup.in",
		password: "password",
		password_confirmation: "password",
		zip: "94114"
	)
		virginia_1 = Order.create!(
			status: 2,
			animal_id: paul.id,
			user_id: virginia.id
		)
		real_cut = RealCut.find_by_cut_id_and_animal_id(filet.id, paul.id)
			Line.create!(
				order_id: virginia_1.id,
				real_cut_id: real_cut.id,
				units: 2,
				sale_price: real_cut.flat_price
			)
			virginia_1.update_attribute(:total, virginia_1.to_total)
			@log << "< Virginia done"

	andrea = User.create!(
		name: "Andrea Woodside",
		email: "andrea@meatup.in",
		password: "password",
		password_confirmation: "password",
		zip: "94114"
	)
		andrea_1 = Order.create!(
			status: 2,
			animal_id: paul.id,
			user_id: andrea.id
		)
		real_cut = RealCut.find_by_cut_id_and_animal_id(sirloin.id, paul.id)
			Line.create!(
				order_id: andrea_1.id,
				real_cut_id: real_cut.id,
				units: 1,
				sale_price: real_cut.flat_price
			)
			andrea_1.update_attribute(:total, andrea_1.to_total)
			@log << "< Andrea done"

	james = User.create!(
		name: "James Ruggiero",
		email: "james@meatup.in",
		password: "password",
		password_confirmation: "password",
		zip: "94114"
	)
		james_1 = Order.create!(
			status: 2,
			animal_id: paul.id,
			user_id: james.id
		)
		real_cut = RealCut.find_by_cut_id_and_animal_id(eye.id, paul.id)
			Line.create!(
				order_id: james_1.id,
				real_cut_id: real_cut.id,
				units: 1,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(chuck.id, paul.id)
			Line.create!(
				order_id: james_1.id,
				real_cut_id: real_cut.id,
				units: 1,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(offal.id, paul.id)
			Line.create!(
				order_id: james_1.id,
				real_cut_id: real_cut.id,
				units: 1,
				sale_price: real_cut.flat_price
			)
			james_1.update_attribute(:total, james_1.to_total)
			@log << "< James done"

	maura = User.create!(
		name: "Maura Thompson",
		email: "maura@meatup.in",
		password: "password",
		password_confirmation: "password",
		zip: "94114"
	)
		maura_1 = Order.create!(
			status: 2,
			animal_id: paul.id,
			user_id: maura.id
		)
		real_cut = RealCut.find_by_cut_id_and_animal_id(stew.id, paul.id)
			Line.create!(
				order_id: maura_1.id,
				real_cut_id: real_cut.id,
				units: 2,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(brisket.id, paul.id)
			Line.create!(
				order_id: maura_1.id,
				real_cut_id: real_cut.id,
				units: 1,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(ground.id, paul.id)
			Line.create!(
				order_id: maura_1.id,
				real_cut_id: real_cut.id,
				units: 2,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(top.id, paul.id)
			Line.create!(
				order_id: maura_1.id,
				real_cut_id: real_cut.id,
				units: 1,
				sale_price: real_cut.flat_price
			)
			maura_1.update_attribute(:total, maura_1.to_total)
			@log << "< Maura done"

		sasha_1 = Order.create!(
			status: 2,
			animal_id: paul.id,
			user_id: sasha.id
		)
		real_cut = RealCut.find_by_cut_id_and_animal_id(flap.id, paul.id)
			Line.create!(
				order_id: sasha_1.id,
				real_cut_id: real_cut.id,
				units: 2,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(ground.id, paul.id)
			Line.create!(
				order_id: sasha_1.id,
				real_cut_id: real_cut.id,
				units: 2,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(porter.id, paul.id)
			Line.create!(
				order_id: sasha_1.id,
				real_cut_id: real_cut.id,
				units: 3,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(ribeye.id, paul.id)
			Line.create!(
				order_id: sasha_1.id,
				real_cut_id: real_cut.id,
				units: 3,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(cross.id, paul.id)
			Line.create!(
				order_id: sasha_1.id,
				real_cut_id: real_cut.id,
				units: 4,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(offal.id, paul.id)
			Line.create!(
				order_id: sasha_1.id,
				real_cut_id: real_cut.id,
				units: 1,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(t.id, paul.id)
			Line.create!(
				order_id: sasha_1.id,
				real_cut_id: real_cut.id,
				units: 3,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(stew.id, paul.id)
			Line.create!(
				order_id: sasha_1.id,
				real_cut_id: real_cut.id,
				units: 1,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(shank.id, paul.id)
			Line.create!(
				order_id: sasha_1.id,
				real_cut_id: real_cut.id,
				units: 1,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(fat.id, paul.id)
			Line.create!(
				order_id: sasha_1.id,
				real_cut_id: real_cut.id,
				units: 1,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(top.id, paul.id)
			Line.create!(
				order_id: sasha_1.id,
				real_cut_id: real_cut.id,
				units: 1,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(rump.id, paul.id)
			Line.create!(
				order_id: sasha_1.id,
				real_cut_id: real_cut.id,
				units: 1,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(sirloin.id, paul.id)
			Line.create!(
				order_id: sasha_1.id,
				real_cut_id: real_cut.id,
				units: 4,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(porter.id, paul.id)
			Line.create!(
				order_id: sasha_1.id,
				real_cut_id: real_cut.id,
				units: 7,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(tri.id, paul.id)
			Line.create!(
				order_id: sasha_1.id,
				real_cut_id: real_cut.id,
				units: 2,
				sale_price: real_cut.flat_price
			)
			sasha_1.update_attribute(:total, sasha_1.to_total)
			@log << "< Sasha done"

	loren = User.create!(
		name: "Loren Kwan",
		email: "loren@meatup.in",
		password: "password",
		password_confirmation: "password",
		zip: "94114"
	)
		loren_1 = Order.create!(
			status: 2,
			animal_id: paul.id,
			user_id: loren.id
		)
		real_cut = RealCut.find_by_cut_id_and_animal_id(skirt.id, paul.id)
			Line.create!(
				order_id: loren_1.id,
				real_cut_id: real_cut.id,
				units: 1,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(offal.id, paul.id)
			Line.create!(
				order_id: loren_1.id,
				real_cut_id: real_cut.id,
				units: 1,
				sale_price: real_cut.flat_price
			)
			loren_1.update_attribute(:total, loren_1.to_total)

		loren_2 = Order.create!(
			status: 2,
			animal_id: paul.id,
			user_id: loren.id
		)
		real_cut = RealCut.find_by_cut_id_and_animal_id(ground.id, paul.id)
			Line.create!(
				order_id: loren_2.id,
				real_cut_id: real_cut.id,
				units: 1,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(tri.id, paul.id)
			Line.create!(
				order_id: loren_2.id,
				real_cut_id: real_cut.id,
				units: 1,
				sale_price: real_cut.flat_price
			)
			loren_2.update_attribute(:total, loren_2.to_total)
			@log << "< Loren done"

	vincent = User.create!(
		name: "Vincent Casotti",
		email: "vincent@meatup.in",
		password: "password",
		password_confirmation: "password",
		zip: "94114"
	)
		vincent_1 = Order.create!(
			status: 2,
			animal_id: paul.id,
			user_id: vincent.id
		)
		real_cut = RealCut.find_by_cut_id_and_animal_id(ground.id, paul.id)
			Line.create!(
				order_id: vincent_1.id,
				real_cut_id: real_cut.id,
				units: 2,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(stew.id, paul.id)
			Line.create!(
				order_id: vincent_1.id,
				real_cut_id: real_cut.id,
				units: 1,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(ribeye.id, paul.id)
			Line.create!(
				order_id: vincent_1.id,
				real_cut_id: real_cut.id,
				units: 1,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(t.id, paul.id)
			Line.create!(
				order_id: vincent_1.id,
				real_cut_id: real_cut.id,
				units: 1,
				sale_price: real_cut.flat_price
			)
			vincent_1.update_attribute(:total, vincent_1.to_total)
			@log << "< Vinny done"

	amy = User.create!(
		name: "Amy Lin",
		email: "amy@meatup.in",
		password: "password",
		password_confirmation: "password",
		zip: "94114"
	)
		amy_1 = Order.create!(
			status: 2,
			animal_id: paul.id,
			user_id: amy.id
		)
		real_cut = RealCut.find_by_cut_id_and_animal_id(top.id, paul.id)
			Line.create!(
				order_id: amy_1.id,
				real_cut_id: real_cut.id,
				units: 1,
				sale_price: real_cut.flat_price
			)
			amy_1.update_attribute(:total, amy_1.to_total)
			@log << "< Amy done"

	lyra = User.create!(
		name: "Lyra Levin",
		email: "lyra@meatup.in",
		password: "password",
		password_confirmation: "password",
		zip: "94114"
	)
		lyra_1 = Order.create!(
			status: 2,
			animal_id: paul.id,
			user_id: lyra.id
		)
		real_cut = RealCut.find_by_cut_id_and_animal_id(ground.id, paul.id)
			Line.create!(
				order_id: lyra_1.id,
				real_cut_id: real_cut.id,
				units: 2,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(stew.id, paul.id)
			Line.create!(
				order_id: lyra_1.id,
				real_cut_id: real_cut.id,
				units: 1,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(top.id, paul.id)
			Line.create!(
				order_id: lyra_1.id,
				real_cut_id: real_cut.id,
				units: 1,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(offal.id, paul.id)
			Line.create!(
				order_id: lyra_1.id,
				real_cut_id: real_cut.id,
				units: 2,
				sale_price: real_cut.flat_price
			)
			lyra_1.update_attribute(:total, lyra_1.to_total)
			@log << "< Lyra done"

	ted = User.create!(
		name: "Ted Blackman",
		email: "ted@meatup.in",
		password: "password",
		password_confirmation: "password",
		zip: "94114"
	)
		ted_1 = Order.create!(
			status: 2,
			animal_id: paul.id,
			user_id: ted.id
		)
		real_cut = RealCut.find_by_cut_id_and_animal_id(stew.id, paul.id)
			Line.create!(
				order_id: ted_1.id,
				real_cut_id: real_cut.id,
				units: 1,
				sale_price: real_cut.flat_price
			)
			ted_1.update_attribute(:total, ted_1.to_total)
			@log << "< Ted done"

	eli = User.create!(
		name: "Eli Scott",
		email: "eli@meatup.in",
		password: "password",
		password_confirmation: "password",
		zip: "94114"
	)
		eli_1 = Order.create!(
			status: 2,
			animal_id: paul.id,
			user_id: eli.id
		) 
		real_cut = RealCut.find_by_cut_id_and_animal_id(ribeye.id, paul.id)
			Line.create!(
				order_id: eli_1.id,
				real_cut_id: real_cut.id,
				units: 1,
				sale_price: real_cut.flat_price
			)
			eli_1.update_attribute(:total, eli_1.to_total)
			@log << "< Eli done"

	ashley = User.create!(
		name: "Ashley Meyer",
		email: "ashley@meatup.in",
		password: "password",
		password_confirmation: "password",
		zip: "94114"
	)
		ashley_1 = Order.create!(
			status: 2,
			animal_id: paul.id,
			user_id: ashley.id
		) 
		real_cut = RealCut.find_by_cut_id_and_animal_id(ground.id, paul.id)
			Line.create!(
				order_id: ashley_1.id,
				real_cut_id: real_cut.id,
				units: 1,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(skirt.id, paul.id)
			Line.create!(
				order_id: ashley_1.id,
				real_cut_id: real_cut.id,
				units: 1,
				sale_price: real_cut.flat_price
			)
			ashley_1.update_attribute(:total, ashley_1.to_total)
			@log << "< Ashley done"

	laura = User.create!(
		name: "Laura Spiekerman",
		email: "laura@meatup.in",
		password: "password",
		password_confirmation: "password",
		zip: "94114"
	)
		laura_1 = Order.create!(
			status: 2,
			animal_id: paul.id,
			user_id: laura.id
		) 
		real_cut = RealCut.find_by_cut_id_and_animal_id(brisket.id, paul.id)
			Line.create!(
				order_id: laura_1.id,
				real_cut_id: real_cut.id,
				units: 1,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(short.id, paul.id)
			Line.create!(
				order_id: laura_1.id,
				real_cut_id: real_cut.id,
				units: 2,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(porter.id, paul.id)
			Line.create!(
				order_id: laura_1.id,
				real_cut_id: real_cut.id,
				units: 1,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(ribeye.id, paul.id)
			Line.create!(
				order_id: laura_1.id,
				real_cut_id: real_cut.id,
				units: 1,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(skirt.id, paul.id)
			Line.create!(
				order_id: laura_1.id,
				real_cut_id: real_cut.id,
				units: 1,
				sale_price: real_cut.flat_price
			)
			real_cut = RealCut.find_by_cut_id_and_animal_id(ground.id, paul.id)
			Line.create!(
				order_id: laura_1.id,
				real_cut_id: real_cut.id,
				units: 3,
				sale_price: real_cut.flat_price
			)
			laura_1.update_attribute(:total, laura_1.to_total)
			@log << "< Laura done"

rescue Exception => e
	full_mgs = ["SEED FAILED", "SUCCESSFUL SECTIONS BELOW:"] + @log
	raise e
ensure
	full_mgs ||= ["SEED SUCCESSFUL:"] + @log + ["DONE"]
	puts full_mgs.split("\n") 
end