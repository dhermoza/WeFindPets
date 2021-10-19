class Chatroom < ApplicationRecord
  has_many :messages, dependent: :destroy
  belongs_to :post
  belongs_to :user
end
