class CreateFelicas < ActiveRecord::Migration
  def change
    create_table :felicas do |t|
      t.string :idm, null: false, unique: true
      t.boolean :activation, null: false, default: false
      t.datetime :activated_at

      t.timestamps
    end

    add_index :felicas, :idm
    add_index :felicas, :activation
  end
end
