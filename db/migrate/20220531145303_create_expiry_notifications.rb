class CreateExpiryNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :expiry_notifications do |t|
      t.references :ingredient, null: false, foreign_key: true
      t.references :fridge, null: false, foreign_key: true
      t.date :exp_date

      t.timestamps
    end
  end
end
