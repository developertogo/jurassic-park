require_dependency '../../app/models/cage.rb'

class CreateCages < ActiveRecord::Migration[7.0]
  def change
    create_enum :power_statuses, Cage::POWER_STATUS.map(&:to_s)

    create_table :cages, id: :uuid do |t|
      t.string :tag, null: false
      t.enum :power_status, enum_type: "power_statuses", null: false
      t.integer :dinosaur_count, default: 0, null: false
      t.integer :max_capacity, default: 1, null: false
      t.string :location, null: false

      t.timestamps, null: false
    end

    add_index(:cages, :tag, unique: true)
    add_index(:cages, :power_status)
  end
end
