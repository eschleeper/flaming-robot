FieldGuide.Views.Guides ||= {}

class FieldGuide.Views.Guides.EditView extends Backbone.View
  template : JST["backbone/templates/guides/edit"]

  events :
    "submit #edit-guide" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (guide) =>
        @model = guide
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
