FieldGuide.Views.WikiImagePages ||= {}

class FieldGuide.Views.WikiImagePages.WikiImagePageView extends Backbone.View
  template: JST["backbone/templates/wiki_image_pages/wiki_image_page"]

  events:
    "click .destroy" : "destroy"

  tagName: "li"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
