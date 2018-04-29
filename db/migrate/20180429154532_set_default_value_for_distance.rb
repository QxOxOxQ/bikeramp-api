class SetDefaultValueForDistance < ActiveRecord::Migration[5.2]
  def change
    change_column :trips, :distance, :float, default: 0
  end
end
