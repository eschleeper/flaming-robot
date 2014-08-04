FieldGuide.Views.GuideItems ||= {}

class FieldGuide.Views.GuideItems.IndexView extends Backbone.View
  template: JST["backbone/templates/guide_items/index"]

  className: 'guide_items_list row'

  initialize: (options) ->
    @section_id = options.section_id
    @options.guideItems.bind('reset', @addAll)
    @options.guideItems.bind('add', @addOne)

  addAll: () =>
    @options.guideItems.each(@addOne)

  addOne: (guideItem) =>
    guideItem.set("section_id",@section_id)
    view = new FieldGuide.Views.GuideItems.GuideItemView({model : guideItem})

    @$el.append(view.render().el)
    if @msnry
      self = this
      view.$el.imagesLoaded () ->
        self.msnry.addItems view.el

  render: =>
    $(@el).html(@template(guideItems: @options.guideItems.toJSON(),section_id: @section_id))
    @$el.attr("id","guide_items_list_" + @section_id)
    @addAll()

    return this
