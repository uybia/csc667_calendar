class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.string :event
      t.string :time
      t.string :month
      t.integer :day
      t.integer :year

      t.timestamps
    end
  end
end
