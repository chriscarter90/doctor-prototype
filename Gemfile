source 'http://rubygems.org'

gem 'rails', '3.2.8'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'pg'

gem 'annotate', ">=2.5.0"
gem 'faker'

gem 'resque', :require => 'resque/server'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'uglifier'
  gem 'therubyracer', :platform => :ruby
  gem "less-rails" #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
  gem "twitter-bootstrap-rails"
end

gem 'jquery-rails'

gem 'rspec-rails', :group => [:test, :development]
gem 'railroady', :group => [:test, :development]

group :development do
  gem 'guard'
  gem 'guard-rspec'
end

# Use unicorn as the web server
gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano'

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
  gem 'database_cleaner'

  # To use debugger
  gem 'debugger'
  gem 'shoulda-matchers'

  gem 'capybara'
  gem 'launchy'
  gem 'factory_girl_rails'

  gem 'rspec'
  gem 'growl'
  gem 'rb-fsevent'
  gem 'spork-rails'
  gem 'guard-spork'

  gem 'tinytable'
end
