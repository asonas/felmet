class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.references :felica
      t.string :name

      t.timestamps
    end
  end
end
