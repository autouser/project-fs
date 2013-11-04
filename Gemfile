source 'https://rubygems.org'

gem 'rails', '3.2.15'
gem 'sqlite3'
gem 'jquery-rails'
gem 'database_cleaner', '1.0.1'
gem 'simple_form'
gem 'devise'
gem 'haml'
gem 'ancestry'
gem 'carrierwave'
gem 'jquery-fileupload-rails'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'therubyracer', :platforms => :ruby
  gem 'less-rails'
  gem 'twitter-bootstrap-rails'
end

group :test, :development do
  gem 'rspec-rails'
  gem 'cucumber-rails', require: false

  gem 'capybara'
  gem 'poltergeist'
  gem "selenium-webdriver"

  # temporary fix for poltergeist
  gem 'faye-websocket', '0.4.7'
end

gem "erb2haml", :group => :development