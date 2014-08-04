class FieldGuide.Routers.WikiImagePagesRouter extends Backbone.Router
  initialize: (options) ->
    @wikiImagePages = new FieldGuide.Collections.WikiImagePagesCollection()
    @wikiImagePages.reset options.wikiImagePages

  routes:
    "new"      : "newWikiImagePage"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newWikiImagePage: ->
    @view = new FieldGuide.Views.WikiImagePages.NewView()
    $("#wiki_image_pages").html(@view.render().el)

  index: ->
    #@view = new FieldGuide.Views.WikiImagePages.IndexView(wikiImagePages: @wikiImagePages)
    # $("#wiki_image_pages").html(@view.render().el)

  show: (id) ->
    wiki_image_page = @wiki_image_pages.get(id)

    @view = new FieldGuide.Views.WikiImagePages.ShowView(model: wiki_image_page)
    #$("#wiki_image_pages").html(@view.render().el)

  edit: (id) ->
    wiki_image_page = @wiki_image_pages.get(id)

    @view = new FieldGuide.Views.WikiImagePages.EditView(model: wiki_image_page)
    #$("#wiki_image_pages").html(@view.render().el)
