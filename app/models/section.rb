class Section < ActiveRecord::Base
  belongs_to :guide
  has_many  :guide_items
  has_many :critters, through: :guide_items
  
  def as_json(args)
    super(:only => [:name, :id, :guide_id], :include => {
      :guide_items => { :only => [:id, :guide_id ], :include => {
        :critter => { :only => [:id, :name], :include => {
         :identifying_images => { :only => [ :image, :attribution ] }
        }}
      }}
     })
  end
end
