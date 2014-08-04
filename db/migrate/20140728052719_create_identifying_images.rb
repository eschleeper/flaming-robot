class CreateIdentifyingImages < ActiveRecord::Migration
  def change
    create_table :identifying_images do |t|

      t.integer :critter_id

      t.timestamps
      
    end
  end
end
