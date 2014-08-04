FieldGuide.Views.WikiImagePages ||= {}

class FieldGuide.Views.WikiImagePages.ShowView extends Backbone.View
  template: JST["backbone/templates/wiki_image_pages/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
