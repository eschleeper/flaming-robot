FieldGuide.Views.Sections ||= {}

class FieldGuide.Views.Sections.NewView extends Backbone.View
  template: JST["backbone/templates/sections/new"]

  events:
    "submit #new-section": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()
    @model.set("guide_id", options.guide_id)

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    this.$el.parents(".reveal-modal").trigger('reveal:close')
    @collection.create(@model.toJSON(),
      success: (section) =>
        @model = section
        window.location.hash = "/index"

      error: (section, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
