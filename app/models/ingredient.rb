class Ingredient < ApplicationRecord
  belongs_to :fridge
  has_one :expiry_notification, dependent: :destroy

  validate :name, :exp_date, :category, :quantity, :unit, :comment, :fridge, presence: true
end
