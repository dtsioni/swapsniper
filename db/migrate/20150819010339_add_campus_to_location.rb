class AddCampusToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :campus, :string
  end
end
