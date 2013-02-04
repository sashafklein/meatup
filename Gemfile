source 'https://rubygems.org'

gem 'rails', '3.2.11'
gem 'googlecharts', :require => "gchart"
gem 'unicorn'
gem 'newrelic_rpm'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'
group :production do
	gem 'pg'
end

group :development do
	gem 'sqlite3'
	gem 'rspec-rails', '2.11.0'
  gem 'guard-rspec', '1.2.1'
end

group :test do 
	gem 'capybara', '1.1.2'
  gem 'rb-fsevent', '0.9.1'
  gem 'growl', '1.0.3'
  gem 'guard-spork', '1.2.0'
  gem 'spork', '0.9.2'
  gem 'factory_girl_rails', '4.1.0'
end

gem 'annotate', '2.5.0'
gem 'faker', '1.0.1'
gem 'will_paginate', '3.0.3'
gem 'bootstrap-will_paginate', '0.0.6'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'bootstrap-sass', '2.0.4'
  gem 'bcrypt-ruby', '3.0.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'roadie'
gem 'stripe', :git => 'https://github.com/stripe/stripe-ruby'
gem 'delayed_job_active_record'
gem 'daemons'
gem 'foreman'
gem 'hirefire'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
