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
    r = Random.new
    location = ["Ankara", "New York", "Antalya", "Bursa", "Istanbul",
                "Izmir", "San Francisco", "San Diego", "Boston", "Miami"]
    l= Random.new

    30.times do |n|
      email = "example-#{n+1}@yahoo.com"
      password = "guney"
      User.create!(
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end
    User.all(:limit => 6).each do |user|
      10.times do
      cat_id = r.rand(1..34)
      loc = l.rand(0..9)
        user.jobs.create!(:title => Faker::Lorem.sentence(1),
                          :body => Faker::Lorem.sentence,
                          :location => location[loc],
                          :category_id => cat_id)
      end
    end
  end
end