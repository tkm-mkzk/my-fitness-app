class CreateBenchPressWeightRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :bench_press_weight_records do |t|
      t.float      :bench_press_weight
      t.date       :bench_press_day
      t.references :user,               foreign_key: true
      t.timestamps
    end
  end
end
