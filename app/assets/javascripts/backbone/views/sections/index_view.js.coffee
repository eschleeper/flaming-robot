FieldGuide.Views.Sections ||= {}

class FieldGuide.Views.Sections.IndexView extends Backbone.View
  template: JST["backbone/templates/sections/index"]

  initialize: () ->
    @options.sections.bind('reset', @addAll)

  addAll: () =>
    @options.sections.each(@addOne)

  addOne: (section) =>
    view = new FieldGuide.Views.Sections.SectionView({model : section})
    @$("#sections-list").append(view.render().$el)

  render: =>
    $(@el).html(@template(sections: @options.sections.toJSON() ))
    @addAll()

    return this
