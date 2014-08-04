class FieldGuide.Routers.GuidesRouter extends Backbone.Router
  initialize: (options) ->
    @guides = new FieldGuide.Collections.GuidesCollection()
    @guides.reset options.guides

  routes:
    "new"      : "newGuide"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newGuide: ->
    @view = new FieldGuide.Views.Guides.NewView(collection: @guides)
    $("#guides").html(@view.render().el)

  index: ->
    @view = new FieldGuide.Views.Guides.IndexView(guides: @guides)
    $("#guides").html(@view.render().el)

  show: (id) ->
    guide = @guides.get(id)

    @view = new FieldGuide.Views.Guides.ShowView(model: guide)
    $("#guides").html(@view.render().el)

  edit: (id) ->
    guide = @guides.get(id)

    @view = new FieldGuide.Views.Guides.EditView(model: guide)
    $("#guides").html(@view.render().el)
