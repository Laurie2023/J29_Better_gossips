class City < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :users
  has_many :gossips, through: :users
end
