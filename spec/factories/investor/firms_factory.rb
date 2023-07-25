FactoryBot.define do
  factory :investor_firm, class: "Investor::Firm" do
    sequence(:id) { SecureRandom.uuid }
    name { Faker::Company.name }
    thesis { Faker::Company.catch_phrase }
    overview { Faker::Company.catch_phrase }

    transient do
      url_safe_name { name.gsub(" ", "-") }
    end

    site_url { Faker::Internet.url(host: "relaunchcommunity.org", path: "/#{url_safe_name.downcase}", scheme: "https") }

    physical_location factory: :physical_location_complete
  end
end
