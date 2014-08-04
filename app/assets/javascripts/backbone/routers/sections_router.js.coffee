class FieldGuide.Routers.SectionsRouter extends Backbone.Router
  initialize: (options) ->
    @sections = new FieldGuide.Collections.SectionsCollection()
    @sections.reset options.sections
    @guide_id = options.guide_id

  routes:
    "new"      : "newSection"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newSection: ->
    @view = new FieldGuide.Views.Sections.NewView(collection: @sections, guide_id: @guide_id)
    $("#modal-form").html(@view.render().el).reveal()

  index: ->
    @view = new FieldGuide.Views.Sections.IndexView(sections: @sections)
    $("#modal-form").trigger('reveal:close')
    $("#sections").html(@view.render().el)

  edit: (id) ->
    section = @sections.get(id)

    @view = new FieldGuide.Views.Sections.EditView(model: section)
    $("#modal-form").html(@view.render().el).reveal()
