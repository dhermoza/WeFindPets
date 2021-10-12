class Pet < ApplicationRecord
  belongs_to :user
  has_many :posts
  # validates :size, :gender, :color, :breed, :status, :animal, presence: true
end
