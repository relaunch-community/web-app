FactoryBot.define do
  factory :user do
    transient do
      uuid { SecureRandom.uuid }
    end

    before(:create) do |user, evaluator|
      user.id = evaluator.uuid
    end

    trait :with_encrypted_password do
      encrypted_password {}
    end

    sequence(:email) { |n| Faker::Internet.email(name: "#{Faker::Name.name}#{n}") }
    sequence(:password) { Faker::Internet.password(min_length: 16, max_length: 128, special_characters: true) }

    trait :with_admin do
      roles { ["admin"] }
    end

    # https://github.com/thoughtbot/factory_bot/blob/main/GETTING_STARTED.md#has_many-associations
    factory :user_with_personal_profile do
      after(:create) do |user, evaluator|
        create(:user_profile_personal, user: user)

        user.reload
      end
    end
  end
end
