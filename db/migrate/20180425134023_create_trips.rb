class CreateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.float :distance
      t.float :price, null: false
      t.date :date, null: false
      t.string :start, null: false
      t.string :end, null: false
      t.timestamps
    end
  end
end
