class Guide < ActiveRecord::Base
  has_many :sections, dependent: :destroy
  
  def as_json(args)
    super(:include => {
      :sections => {:only => [:name, :id, :guide_id], :include => :guide_items }
      })
  end
end
