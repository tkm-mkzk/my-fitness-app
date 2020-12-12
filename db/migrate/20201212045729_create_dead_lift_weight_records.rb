class CreateDeadLiftWeightRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :dead_lift_weight_records do |t|
      t.float      :dead_lift_weight,   null: false
      t.date       :dead_lift_day,      null: false
      t.references :user,               foreign_key: true
      t.timestamps
    end
  end
end
