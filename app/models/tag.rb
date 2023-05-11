class Tag < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  
  has_many :join_tag_gossips
  has_many :gossips, through: :join_tag_gossips
  has_many :users, through: :gossips
end
