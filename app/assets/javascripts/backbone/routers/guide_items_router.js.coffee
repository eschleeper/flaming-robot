class FieldGuide.Routers.GuideItemsRouter extends Backbone.Router
  initialize: (options) ->
    @guideItems = new FieldGuide.Collections.GuideItemsCollection()
    @guideItems.reset options.guideItems

  routes:
    "new"      : "newGuideItem"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newGuideItem: ->
    @view = new FieldGuide.Views.GuideItems.NewView(collection: @guide_items)
    $("#guide_items").html(@view.render().el)

  index: ->
    @view = new FieldGuide.Views.GuideItems.IndexView(guide_items: @guide_items)
    $("#guide_items").html(@view.render().el)

  show: (id) ->
    guide_item = @guide_items.get(id)

    @view = new FieldGuide.Views.GuideItems.ShowView(model: guide_item)
    $("#guide_items").html(@view.render().el)

  edit: (id) ->
    guide_item = @guide_items.get(id)

    @view = new FieldGuide.Views.GuideItems.EditView(model: guide_item)
    $("#guide_items").html(@view.render().el)
