class CreateClothingUsageLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :clothing_usage_logs do |t|
      t.references :cloth, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamp :used_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }

      t.timestamps
    end
  end
end
