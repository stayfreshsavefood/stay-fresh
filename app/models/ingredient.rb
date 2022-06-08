require 'date'
class Ingredient < ApplicationRecord
  belongs_to :fridge
  has_one :expiry_notification, dependent: :destroy

  validates :name, :exp_date, :category, :quantity, :unit, :fridge, presence: true

  validates :category, inclusion: { in: ['Fruits & Veggies', 'Eggs & Dairy', 'Meat & Poultry', 'Seafood', 'Others'],
    message: "%{value} is not a valid category" }

  include PgSearch::Model
  pg_search_scope :search_by_name,
    against: [ :name, :category ],
    using: {
      tsearch: { prefix: true }
    }

  def how_long
    (self.exp_date - Date.today).to_i
  end
end
