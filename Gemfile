source 'https://rubygems.org'

ruby '2.2.1'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
gem 'jquery-turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.2'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'slim-rails'
gem 'compass'

gem 'sidekiq'
gem 'warden'

gem 'foreman'


group :mpq do
  gem 'ffi'
  gem 'bindata'
  gem 'rbzip2', github: 'koraktor/rbzip2'
end

source 'https://rails-assets.org' do
  gem 'rails-assets-semantic-ui'
  gem 'rails-assets-parsleyjs'
  gem 'rails-assets-noty'
end

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development do
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'annotate'
end 

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'ffaker'
end


group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'poltergeist'
end
