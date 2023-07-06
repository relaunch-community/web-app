FactoryBot.define do
  factory :user do
    trait :with_encrypted_password do
      encrypted_password {}
    end

    email { Faker::Internet.email(name: Faker::Name.name) }
    password { Faker::Internet.password(min_length: 16, max_length: 128, special_characters: true) }

    # https://github.com/thoughtbot/factory_bot/blob/main/GETTING_STARTED.md#has_many-associations
    factory :user_with_personal_profile do
      after(:create) do |user, evaluator|
        create(:user_profile_personal, user: user)

        user.reload
      end
    end
  end
end
