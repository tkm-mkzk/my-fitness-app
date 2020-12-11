class CreateBenchPressWeightRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :bench_press_weight_records do |t|
      t.integer    :bench_press_weight, null: false
      t.date       :bench_press_day,    null: false
      t.references :user,               foreign_key: true
      t.timestamps
    end
  end
end
