FieldGuide.Views.GuideItems ||= {}

class FieldGuide.Views.GuideItems.ShowView extends Backbone.View
  template: JST["backbone/templates/guide_items/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
