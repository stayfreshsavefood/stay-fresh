class Fridge < ApplicationRecord
  has_many :fridge_users
  has_many :users, through: :fridge_users

  validates :name, presence: true
  validates :users, presence: true
end
