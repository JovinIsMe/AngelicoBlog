FactoryBot.define do
  factory :author do
    name { FFaker::Name.first_name }
  end
end
