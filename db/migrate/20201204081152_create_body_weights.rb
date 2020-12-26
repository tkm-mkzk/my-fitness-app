class CreateBodyWeights < ActiveRecord::Migration[6.0]
  def change
    create_table :body_weights do |t|
      t.float      :weight
      t.date       :day
      t.references :user,   foreign_key: true
      t.timestamps
    end
  end
end
