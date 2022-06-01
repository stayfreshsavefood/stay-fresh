class Fridge < ApplicationRecord
  has_many :fridge_users, dependent: :destroy
  has_many :users, through: :fridge_users
  has_many :ingredients, dependent: :destroy
  has_many :expiry_notifications, dependent: :destroy

  validates :name, presence: true
  # validates :users, presence: true
end
