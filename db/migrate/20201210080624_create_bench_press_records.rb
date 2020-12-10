class CreateBenchPressRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :bench_press_records do |t|
      t.integer    :weight, null: false
      t.date       :day,    null: false
      t.references :user,   foreign_key: true
      t.timestamps
    end
  end
end
