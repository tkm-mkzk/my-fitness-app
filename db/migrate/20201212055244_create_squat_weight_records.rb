class CreateSquatWeightRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :squat_weight_records do |t|
      t.float      :squat_weight,   null: false
      t.date       :squat_day,      null: false
      t.references :user,           foreign_key: true
      t.timestamps
    end
  end
end
