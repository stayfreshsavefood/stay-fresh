class AddFridgeToInvitation < ActiveRecord::Migration[7.0]
  def change
    add_reference :invite_notifications, :fridge, foreign_key: true
  end
end
