FactoryBot.define do
  factory :measure do
    association :user
    body_weight { 65.5 }
    calorie {}
    neck {}
    shoulder {}
    chest {}
    left_biceps {}
    right_biceps {}
    left_forearm {}
    right_forearm {}
    upper_abdomen {}
    lower_abdomen {}
    waist {}
    hips {}
    left_thigh {}
    right_thigh {}
    left_calf {}
    right_calf {}
    date { '2020/2/2' }
  end
end
