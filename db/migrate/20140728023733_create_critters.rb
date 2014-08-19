class CreateCritters < ActiveRecord::Migration
  def change
    create_table :critters do |t|
      t.string :name
      t.string :latin_name

      t.timestamps
    end
    
    create_table :birds do |t|
      t.integer :code
    end
  end
end
