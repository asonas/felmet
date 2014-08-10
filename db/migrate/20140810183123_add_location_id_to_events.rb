class AddLocationIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :location_id, :integer
    add_index :events, :location_id
    change_column :events, :location_id, :integer, null: false
  end
end
