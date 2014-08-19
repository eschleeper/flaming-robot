FieldGuide.Views.GuideItems ||= {}

class FieldGuide.Views.GuideItems.GuideItemView extends Backbone.View
  template: JST["backbone/templates/guide_items/guide_item"]

  events:
    "click .destroy" : "destroy"

  tagName: "div"
 

  destroy: () ->
    this.$el.remove()
    @model.destroy
      success: (model, response) =>
        window.location.hash = "/index"
    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    $(@el).find(".popup").magnificPopup({
      type: 'image',
      closeOnContentClick: true,
      mainClass: 'mfp-img-mobile',
      image: {
        verticalFit: true
      },
      zoom: {
        enabled: true,
        duration: 300,
        opener: (element)->
          return element.find('img');
      }
      
    });
    return this

