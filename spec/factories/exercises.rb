FactoryBot.define do
  factory :exercise do
    user { nil }
    category { 1 }
    name { 'ベンチプレス' }
  end
end
