class CreateGuides < ActiveRecord::Migration
  def change
    create_table :guides do |t|
      t.string :name
      t.integer :explorer_id

      t.timestamps
    end
  end
end
