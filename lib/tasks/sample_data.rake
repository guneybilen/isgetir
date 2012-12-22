#require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    admin = User.create!(
                 :email => "guneybilen@yahoo.com",
                 :password => "guney",
                 :password_confirmation => "guney"
    )
    admin.toggle!(:is_admin)
    99.times do |n|
      email = "example-#{n+1}@yahoo.com"
      password = "guney"
      User.create!(
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end
    User.all(:limit => 6).each do |user|
      10.times do
        user.jobs.create!(:title => Faker::Lorem.sentence(1), :body => Faker::Lorem.sentence)
      end
    end
  end
end