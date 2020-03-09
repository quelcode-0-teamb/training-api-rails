FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "kingren#{n}" }
    sequence(:email) { |n| "factory-#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    user_private { false }
  end
  factory :user1, class: User do
    name { 'kingmasa' }
    email { 'kingmasa@gmail.com' }
    password { 'a' }
    password_confirmation { 'a' }
    user_private { false }
  end
  factory :user2, class: User do
    name { 'kingyuhi' }
    email { 'kingyuhi@gmail.com' }
    password { 'a' }
    password_confirmation { 'a' }
    user_private { false }
  end
  factory :follower, class: User do
    sequence(:name) { |n| "kinggod#{n}" }
    sequence(:email) { |n| "factory#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    user_private { false }
  end
  factory :followed, class: User do
    sequence(:name) { |n| "kingkitaken#{n}" }
    sequence(:email) { |n| "factoryy#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    user_private { false }
  end
end
