class CreateSchedulings < ActiveRecord::Migration[7.1]
  def change
    create_table :schedulings do |t|
      t.boolean :active
      t.date :occurrenceDate

      t.timestamps
    end
  end
end
