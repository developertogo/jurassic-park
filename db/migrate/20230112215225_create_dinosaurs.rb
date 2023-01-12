class CreateDinosaurs < ActiveRecord::Migration[7.0]
  def change
    create_table :dinosaurs, id: :uuid do |t|
      t.string :name
      t.string :diet
      t.string :species

      t.timestamps
    end
  end
end
