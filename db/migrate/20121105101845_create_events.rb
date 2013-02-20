class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :event_type
      t.string :route
      t.string :map_url
      t.datetime :start_at
      t.datetime :end_at
      t.string :start_at_place
      t.string :end_at_place
      t.integer :distance
      t.string :coverage
      t.string :rate
      t.string :stuff
      t.string :contacts
      t.text :description

      t.timestamps
    end
  end
end
