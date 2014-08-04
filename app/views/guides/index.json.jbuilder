json.array!(@guides) do |guide|
  json.extract! guide, :id, :name, :explorer_id
  json.url guide_url(guide, format: :json)
end
