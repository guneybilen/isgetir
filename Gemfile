source 'http://rubygems.org'

#gem 'rails', '3.1.0'

 ruby "1.9.3"
 gem 'rails', '3.2.2'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

#group :development do
#  gem 'therubyracer', :platforms => :ruby, :require => 'v8'
#end

#gem 'libv8', '3.11.8'
#gem 'therubyracer', "0.11.0"


# therubyracer gem asagıdaki problemi çözüyor:
# guney@pc:~/Desktop/isgetir$ rails s
# /home/guney/.rvm/gems/ruby-1.9.2-p180@rails323/gems/execjs-1.4.0/lib/execjs/ 
# runtimes.rb:51:in `autodetect': Could not find a JavaScript runtime. See 
# https://github.com/sstephenson/execjs for a list of available runtimes. 
# (ExecJS::RuntimeUnavailable)


gem 'pg', :group => [:production]
gem 'thin', :group => [:production]
gem 'eventmachine', '~> 1.0.0.beta.4.1'
gem 'will_paginate', "~> 3.0.2"
gem "meta_on_rails"

group :development do
  gem 'taps', :require => false
end

gem 'exception_notification', git: 'git://github.com/alanjds/exception_notification.git'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  #gem 'sass-rails', "  ~> 3.1.0"
  #gem 'coffee-rails', "~> 3.1.0"
  gem 'sass-rails'
  gem 'coffee-rails'
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
  gem 'rspec-rails' #," ~> 2.6.1"
# version 2.6.1 koymadin mi rake db:migrate
# rspec yuzunden su hatayi veriyor: "undefined method `prerequisites' for nil:NilClass"
  gem 'faker'
  gem 'sqlite3'
end

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  #gem 'factory_girl_rails', '1.0'
  gem 'factory_girl_rails'
  gem 'webrat'
  gem 'minitest'
  gem 'turn', :require => false
end
