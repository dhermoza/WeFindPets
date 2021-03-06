class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :pets
  has_many :posts
  has_many :messages
  # validates :name, :phone, presence: true
  has_one_attached :avatar
  has_many :chatrooms
end
