class PrivateMessage < ApplicationRecord
  validates :recipient_id, presence: true
  validates :sender_id, presence: true

  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User"
end
