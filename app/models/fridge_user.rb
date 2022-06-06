class FridgeUser < ApplicationRecord
  belongs_to :user
  belongs_to :fridge

  validates :user, :fridge, presence: true
  validates :user, uniqueness: { scope: [:user_id, :fridge_id], message: "user already exists" }
end
