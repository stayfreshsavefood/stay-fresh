class InviteNotification < ApplicationRecord
  belongs_to :sender_user, class_name: 'User'
  belongs_to :receiver_user, class_name: 'User'
  belongs_to :fridge

  validates :sender_user, :receiver_user, :email, presence: true
  validates :sender_user, uniqueness: true, uniqueness: { scope: [:receiver_user, :fridge], message: "invite already exits" }

  validate :sender_and_receiver

  def sender_and_receiver
    errors.add(:receiver_user, "sender and receiver cant be the same") if sender_user == receiver_user
  end

  def accept
  end
end
