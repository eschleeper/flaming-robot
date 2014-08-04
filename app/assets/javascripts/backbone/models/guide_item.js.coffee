class FieldGuide.Models.GuideItem extends Backbone.Model
  paramRoot: 'guide_item'

  defaults:
    section_id: null
    critter_id: null
    secion_index: null
  parse: (response) ->
    if response && response.critter
      ret_val = response.critter
      ret_val.id = response.id
      @model = ret_val;
    else
      @model = response

class FieldGuide.Collections.GuideItemsCollection extends Backbone.Collection
  model: FieldGuide.Models.GuideItem
  url: '/guide_items'
