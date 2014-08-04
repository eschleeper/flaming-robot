class IdentifyingImage < ActiveRecord::Base
  
  mount_uploader :image, IdentifyingImageUploader

  scope :images_for, ->(critter_id) { where(:critter_id => critter_id)}

  def as_json(options = {})
    super(:only => [:image, :attribution])
  end
end
