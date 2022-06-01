class ExpiryNotification < ApplicationRecord
  belongs_to :ingredient
  belongs_to :fridge

  validates :ingredient, :fridge, :exp_date, presence: true
end
