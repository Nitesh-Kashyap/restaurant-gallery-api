class CreateGalleries < ActiveRecord::Migration[8.0]
  def change
    create_table :galleries do |t|
      t.string :name
      t.text :description
      t.references :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
