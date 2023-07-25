FactoryBot.define do
  factory :user_profile_personal, class: "UserProfile::Personal" do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }

    transient do
      url_safe_name { full_name.gsub(" ", "-") }
    end

    email_address { Faker::Internet.email(name: url_safe_name, domain: "relaunchcommunity.org") }
    freeform_pronouns { Faker::Lorem.words(number: 3).join("/").truncate(32) }
    linkedin_url { Faker::Internet.url(host: "relaunchcommunity.org", path: "/#{url_safe_name.downcase}", scheme: "https") }
    overview { Faker::Lorem.words(number: 30).join(" ").truncate(1024) }

    prepopulated_pronouns { UserProfile::Personal.prepopulated_pronouns.keys.sample }
    pronoun_visibility { 0 }
    visibility { 0 }

    user
  end
end
