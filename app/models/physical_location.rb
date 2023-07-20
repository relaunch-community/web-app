# == Schema Information
#
# Table name: physical_locations
#
#  id                :uuid             not null, primary key
#  city              :text
#  country           :text
#  state_subdivision :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class PhysicalLocation < ApplicationRecord
  include FriendlyId
  include ::HashFriendable

  after_initialize :set_default_country

  with_options presence: true do
    validates :country
    validates :city
  end

  validates :state_subdivision,
            presence: { if: ->(location) { location.iso3166_subdivisions&.any? } },
            inclusion: {
              in: ->(location) { location.iso3166_subdivisions }, allow_blank: true,
              if: ->(location) { location.iso3166_country.present? }
            }

  def iso3166_country
    ISO3166::Country.find_country_by_any_name(country)
  end

  def iso3166_subdivisions
    iso3166_country&.subdivision_names
  end

  private

  def set_default_country
    self.country ||= ISO3166::Country.find_country_by_alpha2("us").common_name
  end
end
