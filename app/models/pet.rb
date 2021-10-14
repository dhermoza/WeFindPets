class Pet < ApplicationRecord
  belongs_to :user
  has_many :posts, dependent: :destroy
  validates :size, :gender, :color, :breed, :animal, presence: true
  has_many_attached :photos

  BREEDS = [
    ['Todos',nil],
    ['Pitbull','pitbull'],
    ['Shiba inu','shiba inu'],
    ['Schnauzer','schnauzer'],
    ['Pastor aleman','pastor aleman'],
    ['Husky siberiano','husky siberiano'],
    ['Dogo','dogo'],
    ['Mestizo','mestizo'],
    ['Pitbull terrier','pitbull terrier'],
  ]

  SIZE = [
    ['Todos',nil],
    ['Pequeño','pequeño'],
    ['Mediano','mediano'],
    ['Grande','grande'],
  ]

  COLOR = [
    ['Todos',nil],
    ['Blanco','blanco'],
    ['Negro','negro'],
    ['Multi color','multi color'],
  ]

  GENDER = [
    ['Todos',nil],
    ['Hembra','hembra'],
    ['Macho','macho']
  ]


end
