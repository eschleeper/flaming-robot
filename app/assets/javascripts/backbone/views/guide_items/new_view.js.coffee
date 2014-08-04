FieldGuide.Views.GuideItems ||= {}

class FieldGuide.Views.GuideItems.NewView extends Backbone.View
  template: JST["backbone/templates/guide_items/new"]

  events:
    "submit #new-guide_item": "save",
    "click .back": "close_modal"

  constructor: (options) ->
    super(options)
    @model = new @collection.model({"section_id": options.section_id, "section_name":options.section_name})
    @section_id = options.section_id

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")
    
    $(".reveal-modal").trigger('reveal:close')

    @collection.create(@model.toJSON(),
      wait: true
      success: (guide_item) =>
        @model = guide_item
        window.location.hash = "/index"

      error: (guide_item, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    
    this.$("form").backboneLink(@model)
    this.$(".search_critter").autocomplete
      source: "/critters/search",
      select: ( event, ui ) ->
        $(this).parents("form").find(".ui-autocomplete-results").html(
          "<h3>" + ui.item.name + "</h3>"
          $(this).parents("form").find(".critter_id").val(ui.item.id).trigger "change"
        )
    this.$(".search_critter").data('ui-autocomplete')._renderItem = (ul, item) ->
      return $('<li data-id=' + item.id + '>').append('<a>' + item.name).appendTo(ul);


    return this

  close_modal: =>
    $(".reveal-modal").trigger('reveal:close')
