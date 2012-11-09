# By using the symbol ':user' we get Factory Girl to simulate the User model. (This comment is from the book.)
=begin
Factory.define :user1, :class=> User do |user|
  user.email  "guney@guney.com"
  user.password 'foobar'
  user.password_confirmation 'foobar'
end
=end

Factory.define :job1, :class => Job do |job|
  job.title  'mimar'
  job.body 'is ariyorum'
  job.location 'izmir'
  #job.association :user1
end
