class FieldGuide.Models.Critter extends Backbone.Model
  paramRoot: 'guide_item'

  defaults:
    id: null
    name: null

class FieldGuide.Collections.CritterCollection extends Backbone.Collection
  model: FieldGuide.Models.Critter
  url: '/critters'
