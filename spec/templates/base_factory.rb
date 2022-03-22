FactoryBot.define do
  factory :user do
    first_name { FFaker::Name.first_name }
  end
end
