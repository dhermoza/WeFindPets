class Pet < ApplicationRecord
  belongs_to :user
  has_many :posts, dependent: :destroy
  validates :size, :gender, :color, :breed, :animal, presence: true
  has_many_attached :photos
end
