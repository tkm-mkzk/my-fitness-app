class CreateSquatWeightRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :squat_weight_records do |t|
      t.float      :squat_weight
      t.date       :squat_day
      t.references :user,           foreign_key: true
      t.timestamps
    end
  end
end
