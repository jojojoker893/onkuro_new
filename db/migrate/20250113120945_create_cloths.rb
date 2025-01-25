class CreateCloths < ActiveRecord::Migration[8.0]
  def change
    create_table :cloths do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.references :category, null: false, foreign_key: true
      t.references :brand, null: false, foreign_key: true
      t.references :color, null: false, foreign_key: true
      t.text :explanation

      t.timestamps
    end
  end
end
