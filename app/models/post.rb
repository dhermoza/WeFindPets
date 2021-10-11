class Post < ApplicationRecord
  belongs_to :user
  belongs_to :pet
  validates :title, :description, :address, :status, presence: true
end
