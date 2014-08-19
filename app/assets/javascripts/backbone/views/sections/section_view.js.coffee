FieldGuide.Views.Sections ||= {}

class FieldGuide.Views.Sections.SectionView extends Backbone.View
  template: JST["backbone/templates/sections/section"]

  events:
    "click .destroy" : "destroy",
    "click .add-item": "addItem"

  tagName: "div"
  
  className: "columns four"

  destroy: () ->
    this.$el.remove()
    @model.destroy
      success: (model, response) =>
        window.location.hash = "/index"

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    @guideItems = new FieldGuide.Views.GuideItems.IndexView(guideItems: @model.guide_items, section_id: @model.id, section_name: @model.get("name"))
    $(@el).append(@guideItems.render().$el)
    self = this;
    @guideItems.$el.imagesLoaded () ->
      #self.guideItems.msnry = new Masonry( self.guideItems.el, {
      #  itemSelector: '.four.columns',
      #  "gutterWidth": 2
      #});


    return this
  
  addItem: (e) ->
    e.preventDefault()
    @guideItemForm = new FieldGuide.Views.GuideItems.NewView(collection: @model.guide_items, section_id: @model.id, section_name: @model.get("name"))
    $("#modal-form").html(@guideItemForm.render().$el).reveal()
