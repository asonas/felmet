class AddOtherEmailToUser < ActiveRecord::Migration
  def change
    add_column :users, :other_email, :string, after: :email
    add_index :users, :email
    add_index :users, :other_email
  end
end
