FieldGuide.Views.Guides ||= {}

class FieldGuide.Views.Guides.IndexView extends Backbone.View
  template: JST["backbone/templates/guides/index"]

  initialize: () ->
    @options.guides.bind('reset', @addAll)

  addAll: () =>
    @options.guides.each(@addOne)

  addOne: (guide) =>
    view = new FieldGuide.Views.Guides.GuideView({model : guide})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(guides: @options.guides.toJSON() ))
    @addAll()

    return this
