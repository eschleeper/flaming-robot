FieldGuide.Views.Guides ||= {}

class FieldGuide.Views.Guides.ShowView extends Backbone.View
  template: JST["backbone/templates/guides/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
