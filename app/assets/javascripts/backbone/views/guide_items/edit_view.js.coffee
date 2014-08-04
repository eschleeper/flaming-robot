FieldGuide.Views.GuideItems ||= {}

class FieldGuide.Views.GuideItems.EditView extends Backbone.View
  template : JST["backbone/templates/guide_items/edit"]

  events :
    "submit #edit-guide_item" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()
    $(".reveal-modal").trigger('reveal:close')

    @model.save(null,
      success : (guide_item) =>
        @model = guide_item
        window.location.hash = "/index"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
