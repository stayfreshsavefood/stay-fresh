class FridgeUser < ApplicationRecord
  belongs_to :user
  belongs_to :fridge

  validates :user, :fridge, presence: true
end
