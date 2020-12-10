class CreateBodyWeights < ActiveRecord::Migration[6.0]
  def change
    create_table :body_weights do |t|
      t.integer    :weight, null: false
      t.date       :day,    null: false
      t.references :user,   foreign_key: true
      t.timestamps
    end
  end
end
