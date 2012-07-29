
namespace :bootstrap do
  desc "Create the Categories"
  task :default_categories => :environment do
    Category.create( :name => 'Insaat')
    Category.create( :name => 'Saglik')
    Category.create( :name => 'Turizm')
    Category.create( :name => 'Diger')
  end

  desc "Run all bootstrapping tasks"
  task :all => [:default_categories]
end
