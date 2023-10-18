class RenameOccurrenceDateInScheduling < ActiveRecord::Migration[7.1]
  def change
    rename_column :schedulings, :occurrenceDate, :occurrence_date
  end
end
