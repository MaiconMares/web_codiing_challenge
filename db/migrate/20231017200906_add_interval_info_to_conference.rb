class AddIntervalInfoToConference < ActiveRecord::Migration[7.1]
  def change
    add_column :conferences, :start_time, :string
    add_column :conferences, :end_time, :string
  end
end
