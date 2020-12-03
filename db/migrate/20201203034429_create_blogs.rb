class CreateBlogs < ActiveRecord::Migration[6.0]
  def change
    create_table :blogs do |t|
      t.string :title,           null: false
      t.string :target_site,     null: false
      t.text :content,           null: false
      t.references :user,        foreign_key: true
      t.timestamps
    end
  end
end
