FactoryBot.define do
  factory :founder_firm, class: "Founder::Firm" do
    sequence(:id) { SecureRandom.uuid }
    name { Faker::Company.name }
    short_description { Faker::Company.catch_phrase }
    long_description { Faker::Lorem.words(number: 10).join(", ") }

    founded_at { 1.year.ago }
    ended_on { nil }

    firm_kind { 0 }
    firm_kind_justification { Faker::Lorem.words(number: 10).join(", ") }

    review_state { :unapproved }

    visibility { Founder::Firm.visibilities.keys.sample }
    field_visibility { nil }

    target_customer { Faker::Lorem.words(number: 10).join(", ") }
    target_industries { Array.new(3) { Faker::Company.industry }.join(", ") }
    target_locations { Array.new(5) { Faker::Address.state }.join(", ") }

    transient do
      url_safe_name { name.gsub(" ", "-") }
    end

    transient do
      # rubocop:disable FactoryBot/FactoryAssociationWithStrategy
      user { create(:user_with_personal_profile) }
      # rubocop:enable FactoryBot/FactoryAssociationWithStrategy
    end
    professional_profile { user.professional_profile }

    site_url { Faker::Internet.url(host: "relaunchcommunity.org", path: "/#{url_safe_name.downcase}", scheme: "https") }

    headquarters_location factory: :physical_location_complete
    incorporation_location factory: :physical_location_complete
  end
end
