FieldGuide.Views.Sections ||= {}

class FieldGuide.Views.Sections.EditView extends Backbone.View
  template : JST["backbone/templates/sections/edit"]

  events :
    "submit #edit-section" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()
    this.$el.parents(".reveal-modal").trigger('reveal:close')

    @model.save(null,
      success : (section) =>
        @model = section
        window.location.hash = "/index"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
