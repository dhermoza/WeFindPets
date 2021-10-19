class Post < ApplicationRecord
  belongs_to :user
  belongs_to :pet
  validates :title, :description, :address, :status, presence: true
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  has_many :chatrooms
end
