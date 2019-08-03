class CreateVesselTrackPositions < ActiveRecord::Migration
  def change
    create_table :vessel_track_positions do |t|
      t.text :mmsi
      t.text :shipid
      t.integer :status
      t.decimal :speed
      t.decimal :lon
      t.decimal :lat
      t.decimal :course
      t.decimal :heading
      t.datetime :timestamp

      t.timestamps null: false
    end
  end
end
