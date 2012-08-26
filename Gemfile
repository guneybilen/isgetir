source 'http://rubygems.org'

gem 'rails', '3.1.0'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'sqlite3', :group => [:development, :test]

gem 'pg', :group => [:production]
gem 'thin', :group => [:production]
gem 'eventmachine', '~> 1.0.0.beta.4.1'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem 'jquery-rails'

group :development, :test do
  gem 'rspec-rails'," ~> 2.6.1"
# version 2.6.1 koymadin mi rake db:migrate
# rspec yuzunden su hatayi veriyor: "undefined method `prerequisites' for nil:NilClass"
end

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  # Pretty printed test output
  gem 'minitest'
  gem 'turn', :require => false
end
