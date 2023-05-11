class Comment < ApplicationRecord
  validates :content, presence: true
  validates :user_id, presence: true
  validates :gossip_id, presence: true

  belongs_to :gossip
  belongs_to :user
  has_many :likes, as: :imageable
end
