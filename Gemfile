source 'http://rubygems.org'

gem 'rails', '3.1.0'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'sqlite3', :group => [:development, :test]

gem 'pg', :group => [:production]
gem 'thin', :group => [:production]
gem 'eventmachine', '~> 1.0.0.beta.4.1'
gem 'will_paginate', "~> 3.0.2"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem 'jquery-rails'

=begin

  ***************************************************************************
   ERROR OCCURRED FOR RSPEC:
   You have already activated rspec-core 2.1.1, but your Gemfile requires rspec-core 2.6.0.
   Using bundle exec may solve this. (Gem::LoadError)
   Benim anladigim kadariyla: This happens when there is a match conflict between gems in your system
   and the one in your Rails app.

   "The easiest way to avoid this kind of boring stuff is to isolate your gems by creating gemsets.
   I use RVM for this purpose."
   http://stackoverflow.com/questions/7918804/how-do-i-keep-all-gems-in-gemfile-compatible-after-an-update
  ***************************************************************************
   WARNING OCCURRED FOR RSPEC
   Rspec with rails 3.1 gives DEPRECATION WARNING ActiveRecord::Associations::AssociationCollection is deprecated...
   "I had the same problem and fixed it by upgrading to the latest version of will_paginate.
   So, change this: gem 'will_paginate', '3.0.pre2'

   to this: gem "will_paginate", "~> 3.0.2"

   Save your Gemfile then do bundle install."
   http://stackoverflow.com/questions/7553929/rspec-with-rails-3-1-gives-deprecation-warning-activerecordassociationsassoc
   ****************************************************************************

=end

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
  gem 'webrat'
  gem 'minitest'
  gem 'turn', :require => false
end
