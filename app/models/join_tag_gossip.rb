class JoinTagGossip < ApplicationRecord
  validates :gossip_id, presence: true
  validates :tag_id, presence: true
  
  belongs_to :tag
  belongs_to :gossip
end
