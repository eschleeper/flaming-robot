class CreateCritters < ActiveRecord::Migration
  def change
    create_table :critters do |t|
      t.string :name

      t.timestamps
    end
  end
end
