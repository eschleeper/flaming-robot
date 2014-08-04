class AddSectionNumberToSection < ActiveRecord::Migration
  def change
    add_column :sections, :section_number, :string
  end
end
