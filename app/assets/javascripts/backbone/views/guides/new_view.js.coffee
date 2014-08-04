FieldGuide.Views.Guides ||= {}

class FieldGuide.Views.Guides.NewView extends Backbone.View
  template: JST["backbone/templates/guides/new"]

  events:
    "submit #new-guide": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()
    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (guide) =>
        @model = guide
        window.location.hash = "/#{@model.id}"

      error: (guide, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
