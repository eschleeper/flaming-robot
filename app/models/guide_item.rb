class GuideItem < ActiveRecord::Base
  belongs_to :critter
  belongs_to :section
  
  def as_json(options = {})
    super(:only => [:id, :guide_id ], :include => {
        :critter => { :only => [:id, :name], :include => {
         :identifying_images => { :only => [ :image, :attribution ] }
       }}
    })
  end
  
end
