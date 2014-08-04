FieldGuide.Views.WikiImagePages ||= {}

class FieldGuide.Views.WikiImagePages.EditView extends Backbone.View
  template : JST["backbone/templates/wiki_image_pages/edit"]

  events :
    "submit #edit-wiki_image_page" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (wiki_image_page) =>
        @model = wiki_image_page
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
