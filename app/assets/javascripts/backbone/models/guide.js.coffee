class FieldGuide.Models.Guide extends Backbone.Model
  paramRoot: 'guide'

  defaults:
    name: null

class FieldGuide.Collections.GuidesCollection extends Backbone.Collection
  model: FieldGuide.Models.Guide
  url: '/guides'
