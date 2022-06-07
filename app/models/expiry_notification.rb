require 'date'
class ExpiryNotification < ApplicationRecord
  belongs_to :ingredient
  belongs_to :fridge

  validates :ingredient, :fridge, :exp_date, presence: true

  def how_long
    (self.exp_date - Date.today).to_i
  end
end
