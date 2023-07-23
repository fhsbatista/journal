class CreateBodyMetrics < ActiveRecord::Migration[7.0]
  def change
    create_table :body_metrics do |t|
      t.date :date
      t.decimal :weight
      t.decimal :bf
      t.decimal :muscle_weight

      t.timestamps
    end
  end
end
