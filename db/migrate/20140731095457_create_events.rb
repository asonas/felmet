class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :user, index: true
      t.datetime :checkin_at
      t.datetime :checkout_at

      t.timestamps
    end
  end
end
