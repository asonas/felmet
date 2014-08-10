class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :user, index: true, null: false
      t.references :felica, index: true, null: false
      t.timestamp :checkin_at
      t.timestamp :checkout_at

      t.timestamps
    end
  end
end
