class RenameEndToFinishInTrips < ActiveRecord::Migration[5.2]
  def change
    rename_column :trips, :end, :finish
  end
end
