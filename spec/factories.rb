# By using the symbol ':user' we get Factory Girl to simulate the User model. (This comment is from the book.)

Factory.define :user1, :class=> User do |user|
  user.email  "guney@guney.com"
  user.password 'foobar'
  user.password_confirmation 'foobar'
end

Factory.define :user2, :class=> User do |user|
  user.email  "bilen@bilen.com"
  user.password 'foobar'
  user.password_confirmation 'foobar'
end

Factory.define :user3, :class => User do |f|
  f.sequence(:email) { |n| "foo#{n}@example.com" }
  f.password "foobar"
  f.password_confirmation { |u| u.password }
end

Factory.define :job1, :class => Job do |job|
  job.title  'mimar'
  job.body 'is ariyorum'
  job.location 'izmir'
  #job.association :user1
end

Factory.define :user4, :class=> User do |user|
  user.email  "guneybilen@bilen.com"
  user.password 'foobar'
  user.password_confirmation 'foobar'
  user.is_admin 't'
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end