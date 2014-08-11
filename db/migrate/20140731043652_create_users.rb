class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.references :felica
      t.integer :group_id
      t.string :name

      t.timestamps
    end
    add_index :users, :group_id
  end
end
