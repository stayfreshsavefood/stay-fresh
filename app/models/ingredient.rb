class Ingredient < ApplicationRecord
  belongs_to :fridge

  validate :name, :exp_date, :category, :quantity, :unit, :comment, :fridge, presence: true
end
