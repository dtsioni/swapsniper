class AddStyleToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :style, :string
  end
end
