class Ingredient < ApplicationRecord
  belongs_to :fridge
  has_one :expiry_notification, dependent: :destroy

  validates :name, :exp_date, :category, :quantity, :unit, :fridge, presence: true
end
