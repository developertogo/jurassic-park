require_dependency './app/lib/park.rb'

class CreateDinosaurs < ActiveRecord::Migration[7.0]
  def change
    create_enum :diets, Park::Dinosaur::DIET.map(&:to_s)
    create_enum :specieses, Park::Dinosaur::SPECIES.map(&:to_s)

    create_table :dinosaurs, id: :uuid do |t|
      t.belongs_to :cage, type: :uuid, index: true, foreign_key: true
      t.string :name, null: false
      t.enum :diet, enum_type: :diets, null: false
      t.enum :species, enum_type: :specieses, null: false

      t.timestamps
    end

    add_index(:dinosaurs, :name, unique: true)
    add_index(:dinosaurs, :species)
  end
end
