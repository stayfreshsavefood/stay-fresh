class Ingredient < ApplicationRecord
  belongs_to :fridge
  has_one :expiry_notification, dependent: :destroy

  validates :name, :exp_date, :category, :quantity, :unit, :fridge, presence: true

  include PgSearch::Model
  pg_search_scope :search_by_name,
    against: [ :name, :category ],
    using: {
      tsearch: { prefix: true }
    }
end
