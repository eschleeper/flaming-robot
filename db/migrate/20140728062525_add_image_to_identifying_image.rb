class AddImageToIdentifyingImage < ActiveRecord::Migration
  
  def change
    
    add_column :identifying_images, :image, :string
    add_column :identifying_images, :attribution, :string
    
  end
  
end
