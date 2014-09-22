FieldGuide.Views.WikiImagePages ||= {}

class FieldGuide.Views.WikiImagePages.IndexView extends Backbone.View
  template: JST["backbone/templates/wiki_image_pages/index"]

  initialize: (opts) ->
    @critter = opts.critter
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
    search_term = @critter.name.charAt(0).toUpperCase() + @critter.name.slice(1).toLowerCase().replace(/\s+/g, '_')
    $(@el).html(@template(wikiImagePages: @collection.toJSON(), search_term: search_term ))

    return this
