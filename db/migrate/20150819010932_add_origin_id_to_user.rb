class AddOriginIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :origin_id, :integer
  end
end
