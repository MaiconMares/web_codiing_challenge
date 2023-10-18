class AddFileToScheduling < ActiveRecord::Migration[7.1]
  def change
    add_column :schedulings, :file, :string
  end
end
