class Gossip < ApplicationRecord
  validates :title, presence: true, uniqueness: true, length: { in: 3..14 }
  validates :content, presence: true, uniqueness: true
  validates :user_id, presence: true

  belongs_to :user
  has_many :join_tag_gossips
  has_many :comments
  has_many :likes, as: :imageable
  has_many :tags, through: :join_tag_gossips
end
