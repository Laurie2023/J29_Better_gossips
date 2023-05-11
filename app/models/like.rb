class Like < ApplicationRecord
  validates :imageable_id, presence: true
  validates :imageable_type, presence: true
  
  belongs_to :imageable, polymorphic: true
  belongs_to :user
end
