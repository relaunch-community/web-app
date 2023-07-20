json.extract! physical_location, :id, :city, :state_subdivision, :country, :created_at, :updated_at
json.url physical_location_url(physical_location, format: :json)
