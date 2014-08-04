json.array!(@critters) do |critter|
  json.extract! critter, :id, :name
  json.url critter_url(critter, format: :json)
end
