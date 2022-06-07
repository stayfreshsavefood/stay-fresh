class AddEmailColumnToInvitations < ActiveRecord::Migration[7.0]
  def change
    add_column :invite_notifications, :email, :string
  end
end
