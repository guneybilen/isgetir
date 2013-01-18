# By using the symbol ':user' we get Factory Girl to simulate the User model. (This comment is from the book.)

FactoryGirl.define  do

  factory :user1, :class=> User do |user|
    user.email  "guney@guney.com"
    user.password 'foobar'
    user.password_confirmation 'foobar'
  end

  factory :user2, :class=> User do |user|
    user.email  "bilen@bilen.com"
    user.password 'foobar'
    user.password_confirmation 'foobar'
  end

  factory :user3, :class => User do |f|
    f.sequence(:email) { |n| "foo#{n}@example.com" }
    f.password "foobar"
    f.password_confirmation { |u| u.password }
  end

  factory  :job1, :class => Job do |job|
    job.title  'mimar'
    job.body 'is ariyorum'
    job.location 'izmir'
    #job.association :user1
  end

  factory :user4, :class=> User do |user|
    user.email  "guneybilen@bilen.com"
    user.password 'foobar'
    user.password_confirmation 'foobar'
    user.is_admin 't'
  end

  sequence(:email) do |n|
    "person-#{n}@example.com"
  end

  factory  :job, :class => Job do |job|
    job.title "title"
    job.body 'body'
    job.location 'location'
    job.association :user # bu user user_spec'de set ediliyor
  end
end
