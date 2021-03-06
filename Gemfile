source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5.1'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
gem 'bootstrap-sass', '~> 3.3.6'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'active_model_serializers'
# Use jquery as the JavaScript library
gem 'jquery-ui-rails'
gem 'jquery-rails'
gem 'paperclip'

source 'https://rails-assets.org' do
  gem 'rails-assets-tether', '>= 1.1.0'
end
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'devise'
gem 'rake', '< 11.0'
gem 'cancancan', '~> 1.10'
gem 'omniauth'
gem 'omniauth-facebook'
# gem 'rails4-autocomplete'

gem 'jquery-raty-rails', github: 'bmc/jquery-raty-rails'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :test, :development do
  gem "rspec-rails"
  gem "capybara"
  gem "launchy"
  gem "rack_session_access"
  gem "capybara-webkit"
  gem "selenium-webdriver"
  gem "better_errors"
  gem "binding_of_caller"
  gem "factory_girl_rails"
  gem "simplecov"
  gem "database_cleaner"
  gem "sqlite3"
  gem "pry"
  gem "guard-rspec", require: false
  gem "thin"
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :production do
  gem "google-analytics-rails"
  gem "rails_12factor"
end

gem "rails-erd" 
gem "airbrake"
gem "faker"
gem "friendly_id"
