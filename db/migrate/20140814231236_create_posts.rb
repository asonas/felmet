class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :template_name
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
