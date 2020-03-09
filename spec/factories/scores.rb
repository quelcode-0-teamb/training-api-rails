FactoryBot.define do
  factory :score do
    user { nil }
    exercise { nil }
    weight { 30.0 }
    repetitions { 4 }
    interval_time { 40 }
    rpe { 9.5 }
    date { '2020/2/2' }
  end
end
