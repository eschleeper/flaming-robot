class FieldGuide.Models.Section extends Backbone.Model
  paramRoot: 'section'

  defaults:
    name: null
    guide_id: null
    
  initialize: (obj, options) ->
    @guide_items = new FieldGuide.Collections.GuideItemsCollection((if obj && obj.guide_items then obj.guide_items else null), {parse: true})

class FieldGuide.Collections.SectionsCollection extends Backbone.Collection
  model: FieldGuide.Models.Section
  url: '/sections'
