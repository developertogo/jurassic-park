class CreateCages < ActiveRecord::Migration[7.0]
  def change
    create_table :cages, id: :uuid do |t|
      t.integer :max_capacity
      t.integer :dinosaur_count
      t.string :power_status
      t.string :location

      t.timestamps
    end
  end
end
