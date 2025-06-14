class UsageLogClearings < ActiveRecord::Migration[8.0]
  def change
    create_table :usage_log_clearings do |t|
      t.references :clothing, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamp :reduced_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }

      t.timestamps
    end
  end
end
