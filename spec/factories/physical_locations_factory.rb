FactoryBot.define do
  factory :physical_location do
    factory :physical_location_with_country do
      country { "USA" }
    end

    factory :physical_location_with_country_state do
      country { "USA" }
      state_subdivision { "MN" }
    end

    factory :physical_location_complete do
      city { "Minneapolis" }
      country { "USA" }
      state_subdivision { "Minnesota" }
    end
  end
end
