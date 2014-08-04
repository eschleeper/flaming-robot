FieldGuide.Views.WikiImagePages ||= {}

class FieldGuide.Views.WikiImagePages.IndexView extends Backbone.View
  template: JST["backbone/templates/wiki_image_pages/index"]

  initialize: () ->
    @render()
    @collection.bind('reset', @addAll)

  addAll: () =>
    if this.collection.length > 0
      @render()
      @collection.each(@addOne)
    else
      new_model = new FieldGuide.Models.WikiImagePage()
      $(@el).find("#results").html(JST["backbone/templates/wiki_image_pages/form"](new_model.toJSON()))

  addOne: (wikiImagePage) =>
    wikiImagePage.set("critter_id",@collection.id);
    @$("#wiki_image_pages-list").append(new FieldGuide.Views.WikiImagePages.NewView({model : wikiImagePage}).el)

  render: =>
    $(@el).html(@template(wikiImagePages: @collection.toJSON() ))

    return this
