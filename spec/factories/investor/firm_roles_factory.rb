FactoryBot.define do
  factory :investor_firm_role, class: "Investor::FirmRole" do
    sequence(:id) { SecureRandom.uuid }
    sequence(:title) { |n| "#{Faker::Job.title} #{n}" }
    why_here { Faker::Lorem.words(number: 30).join(" ") }
    investment_target_stage { Faker::Lorem.words(number: 30).join(" ") }
    investment_target_locations { Faker::Lorem.words(number: 30).join(", ") }

    investor_firm
    transient do
      # rubocop:disable FactoryBot/FactoryAssociationWithStrategy
      user { create(:user_with_personal_profile) }
      # rubocop:enable FactoryBot/FactoryAssociationWithStrategy
    end
    professional_profile { user.professional_profile }
    physical_location factory: :physical_location_complete
  end
end
