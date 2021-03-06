# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

#require File.dirname(__FILE__) + "/factories"  # rails's upgrade ettikten sonra bu line one extra call yapmaya basladi.
# Rails'i upgrade ettikten sora factories otomatik olarak yuklenmeye basladi. Yukardaki line gereksiz ve fazladan
# olmaya basladi.

#require "webrat"
#require 'webrat/core/matchers'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

#include Webrat::Methods

#Webrat.configure do |config|
#  	config.mode = :rack
#end

RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  #config.include Webrat::HaveTagMatcher



def test_sign_in(user)
          @attr = {:email => user.email, :password => user.password}
          #begin
            #user = Factory(:user2)
          controller.send(:log_in, user.email, user.password)
            #puts controller.send(:current_user).nil?
          #rescue ActiveRecord::RecordInvalid => invalid
          #  puts invalid.record.errors.full_messages
          #end
          response.should be_success
end

end
