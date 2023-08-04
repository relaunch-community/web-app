FactoryBot.define do
  factory :founder_firm_role, class: "Founder::FirmRole" do
    sequence(:title) { |n| "#{Faker::Job.title} #{n}" }
    ownership_percentage { rand(1.0..100.0) }
    ownership_confirmation_checkbox { false }

    joined_at { 1.year.ago }

    visibility { 0 }

    transient do
      # rubocop:disable FactoryBot/FactoryAssociationWithStrategy
      user { create(:user_with_personal_profile) }
      # rubocop:enable FactoryBot/FactoryAssociationWithStrategy
    end

    founder_firm
    professional_profile { user.professional_profile }
  end
end
