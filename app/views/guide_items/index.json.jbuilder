json.array!(@guide_items) do |guide_item|
  json.extract! guide_item, :id, :section_id, :critter_id, :secion_index
  json.url guide_item_url(guide_item, format: :json)
end
