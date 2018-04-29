class RenameAddressesColumnsTrips < ActiveRecord::Migration[5.2]
  def change
    rename_column :trips, :finish, :destination_address
    rename_column :trips, :start, :start_address

  end
end
