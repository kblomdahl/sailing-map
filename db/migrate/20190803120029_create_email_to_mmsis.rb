class CreateEmailToMmsis < ActiveRecord::Migration
  def change
    create_table :email_to_mmsis do |t|
      t.text :email
      t.text :mmsi

      t.timestamps null: false
    end
  end
end
