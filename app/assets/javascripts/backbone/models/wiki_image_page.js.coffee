class FieldGuide.Models.WikiImagePage extends Backbone.Model
  paramRoot: 'critter_identifying_images'
  
  initialize: (obj, options) ->
    if options && options.critter_id
      @critter_id = options.id
      @set({critter_id: options.critter_id})
      @url = '/critters/' + @critter_id + '/identifying_images'

  defaults:
    title: null
    attribution: null
    remote_image_url: null
    critter_id: null

class FieldGuide.Collections.WikiImagePagesCollection extends Backbone.Collection
  model: FieldGuide.Models.WikiImagePage
  
  initialize: (arr, options) ->
    if options && options.id
      @id = options.id
      @url = '/critters/' + options.id + '/identifying_images'
    
