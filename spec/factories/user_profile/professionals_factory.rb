FactoryBot.define do
  factory :user_profile_professional, class: "UserProfile::Professional" do
    user factory: :user
    sequence(:hash_id) { Digest::UUID.uuid_v4 }
  end
end
