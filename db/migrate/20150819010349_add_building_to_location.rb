class AddBuildingToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :building, :string
  end
end
