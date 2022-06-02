class ChangeStatusType < ActiveRecord::Migration[7.0]
  def change
    change_column :invite_notifications, :status, :boolean, using: 'status::boolean'
  end
end
