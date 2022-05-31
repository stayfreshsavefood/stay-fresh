class CreateInviteNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :invite_notifications do |t|
      t.string :status
      t.references :sender_user, null: false, foreign_key: { to_table: :users }
      t.references :receiver_user, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
