FactoryBot.define do
  factory :user_profile_personal, class: "UserProfile::Personal" do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }

    email_address { Faker::Internet.email }
    freeform_pronouns { Faker::Lorem.words(number: 3).join("/").truncate(32) }
    linkedin_url { Faker::Lorem.characters(number: 45, min_alpha: 45) }
    overview { Faker::Lorem.words(number: 30).join(" ").truncate(1024) }

    prepopulated_pronouns { UserProfile::Personal.prepopulated_pronouns.keys.sample }
    pronoun_visibility { 0 }
    visibility { 0 }

    user
  end
end
