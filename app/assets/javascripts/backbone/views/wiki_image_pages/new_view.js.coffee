FieldGuide.Views.WikiImagePages ||= {}

class FieldGuide.Views.WikiImagePages.NewView extends Backbone.View
  template: JST["backbone/templates/wiki_image_pages/new"]

  events:
    "submit .wiki_image_page": "save"
    "click .destroy" : "destroy"

  tagName: "li"

  initialize: (options) ->
    @model = options.model
    @model.bind("change:errors", () =>
      this.render()
    )
    @render()

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")
    $(@el).addClass("saving");
    @model.save(@model.toJSON(),
      emulateJSON:true,
      success: (wiki_image_page) =>
        $(@el).html(JST["backbone/templates/critters/show"](@model.toJSON() ))
        $(@el).removeClass("saving");

      error: (wiki_image_page, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    this.$el.find("form").backboneLink(@model)
    return this
