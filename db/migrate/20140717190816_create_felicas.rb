class CreateFelicas < ActiveRecord::Migration
  def change
    create_table :felicas do |t|
      t.string :idm, null: false
      t.boolean :activation, null: false, default: false
      t.datetime :activated_at

      t.timestamps
    end

    add_index :felicas, :idm, unique: true
    add_index :felicas, :activation
  end
end
