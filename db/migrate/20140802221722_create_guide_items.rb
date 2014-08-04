class CreateGuideItems < ActiveRecord::Migration
  def change
    create_table :guide_items do |t|
      t.integer :section_id
      t.integer :critter_id
      t.integer :secion_index

      t.timestamps
    end
  end
end
