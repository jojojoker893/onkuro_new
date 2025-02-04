class RenameClothIdToClothingId < ActiveRecord::Migration[8.0]
  def change
    rename_column :clothing_usage_logs, :cloth_id, :clothing_id
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
