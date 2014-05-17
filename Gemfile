source 'https://rubygems.org'

ruby '2.0.0'

gem 'rails', '>= 4'
gem 'protected_attributes'
gem 'responders'

# database
gem 'yaml_db'
gem 'mongoid', github: 'mongoid/mongoid'


# frontend
gem 'jquery-rails'
gem 'coffee-rails'
gem 'haml'
gem 'haml-coffee'
gem 'bootstrap-datepicker-rails'

# theme
gem 'sass-rails', '>= 4.0.2'
gem 'bootstrap-sass', '>= 3'
gem 'font-awesome-rails'
gem 'turbolinks'

# authorization
gem 'devise'
gem 'cancan'

# forms
gem 'simple_form', '3.1.0.rc1', github: 'plataformatec/simple_form'

# nawigacja
gem "breadcrumbs_on_rails"

group :assets do
  gem 'uglifier'
end

# attachments
gem "paperclip", "~> 4.1"

# Config file
gem 'a9n'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Pagination
gem 'kaminari'

# slugs
gem "mongoid-simple-tags"
gem 'utf8-cleaner'
gem 'bootsy'

group :doc do
  gem 'yard', require: false
end

group :test do
  # gem 'guard-rspec'
  gem "spring-commands-rspec"
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'faker'
  gem 'mocha',          require: false
  gem 'simplecov',      require: false
  gem 'simplecov-rcov', require: false
  gem 'rspec'
  gem 'parallel_tests'
  gem 'fuubar'
  gem 'factory_girl'
  gem 'capybara'
end

group :development, :test do
  gem 'debugger'
  gem 'spring'
end

group :development, :deployment do
  gem 'capistrano', '< 3'
  gem 'capistrano-ext'
  gem 'capistrano_colors'
  gem 'rvm-capistrano'
  gem 'capistrano-unicorn', require: false
end

group :development do
  gem 'binding_of_caller'
  gem 'better_errors'
  gem 'quiet_assets'
  gem 'thin'
end

group :production do
  gem 'unicorn'
  gem 'execjs'
  gem 'therubyracer' # execjs dependencies
  gem 'libv8'        # execjs dependencies
end
