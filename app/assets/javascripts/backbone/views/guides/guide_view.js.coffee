FieldGuide.Views.Guides ||= {}

class FieldGuide.Views.Guides.GuideView extends Backbone.View
  template: JST["backbone/templates/guides/guide"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
