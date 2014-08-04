class AddTypeToAnimal < ActiveRecord::Migration
  def change
    add_column :critters, :type, :string
    add_column :critters, :description, :text
  end
end
