source 'http://rubygems.org'

#gem 'rake', '0.8.7'
gem 'rails'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

#gem 'sqlite3'

# Database
gem 'mongoid' #, '2.2.3'
gem 'bson_ext'
gem 'trackoid'
gem 'mongoid_slug'
#gem 'mongoid_i18n', :require => 'mongoid/i18n'
gem 'mongoid_auto_increment'
gem 'redis'
gem 'redis-store'

# Markdown
gem 'redcarpet', '1.17.2'

# Pagination
gem 'kaminari'

# search
#gem 'sunspot', "~> 1.3.0.rc6"
#gem "sunspot_rails", "~> 1.3.0.rc6"
gem 'sunspot_mongoid'

# Crypt
gem 'bcrypt-ruby', :require => "bcrypt"

# Omniauth - Twitter - Facebook
gem "omniauth", ">= 1.0.0"
gem 'omniauth-twitter'
gem 'omniauth-facebook', '1.0.0'
gem 'omniauth-google-oauth2'
gem "twitter", "2.0.0"
gem "fb_graph", "2.2.2"

#Pretty Forms
gem 'simple_form'

#Images
gem 'rmagick'
gem 'carrierwave', "0.5.7"
gem 'carrierwave-mongoid', :require => 'carrierwave/mongoid'
gem 'fog'   # S3 storage

# Mail from tabelia
gem "aws-ses", "~> 0.4.4", :require => 'aws/ses'

# Background jobs
gem 'resque'

gem 'juggernaut'
gem 'therubyracer'

# Active Merchant
gem 'activemerchant', :require => 'active_merchant'

# PDFs
gem 'prawn', '1.0.0.rc1'

# Country task
gem 'hpricot'

# Geolocalization
gem 'geocoder'

gem 'fotolia_rest'

group :development do
  gem 'faker'
  gem 'sunspot_solr'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem 'jquery-rails'

gem 'thin'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end
