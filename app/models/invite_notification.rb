class InviteNotification < ApplicationRecord
  belongs_to :sender_user, class_name: 'User'
  belongs_to :receiver_user, class_name: 'User'

  validates :sender_user, :receiver_user, :status, presence: true
  validates :sender_user, uniqueness: true, uniqueness: { scope: :receiver_user,
    message: "invite already exits" }

  validate :sender_and_receiver

  def sender_and_receiver
    errors.add(:receiver_user, "sender and receiver cant be the same") if sender_user == receiver_user
  end
end
