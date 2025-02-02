class RenameClothsToClothing < ActiveRecord::Migration[8.0]
  def change
    rename_table :cloths, :clothings
  end
end
