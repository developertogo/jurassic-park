require_dependency '../../app/models/dinosaur.rb'

class CreateDinosaurs < ActiveRecord::Migration[7.0]
  def change
    create_enum :diets, Dinosaur.DIET.map(&:to_s)
    create_enum :specieses, Dinosaur.SPECIES.map(&:to_s)

    create_table :dinosaurs, id: :uuid do |t|
      t.belongs_to :cage, index: true, foreign_key: true
      t.string :name, null: false
      t.enum :diet, enum_type: "diets", null: false
      t.enum :species, enum_type: "specieses", null: false

      t.timestamps, null: false
    end

    add_index(:dinosaurs, :name, unique: true)
    add_index(:dinosaurs, :species)
  end
end
