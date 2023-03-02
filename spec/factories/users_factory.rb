FactoryBot.define do
  factory :user do
    trait :with_encrypted_password do
      encrypted_password {}
    end
    email { Faker::Internet.email(name: Faker::Name.name) }
    password { Faker::Internet.password(min_length: 16, max_length: 128, special_characters: true) }
  end
end
