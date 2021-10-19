require "json"
require "rest-client"

class Pet < ApplicationRecord
  belongs_to :user
  has_many :posts, dependent: :destroy
  validates :size, :gender, :color, :breed, :animal, presence: true
  has_many_attached :photos

  SIZE = [
    ['Todos',nil],
    ['Otros','otros'],
    ['Toy','toy'],
    ['Pequeño','pequeño'],
    ['Mediano','mediano'],
    ['Grande','grande'],
  ]

  COLOR = [
    ['Todos',nil],
    ['Otros','otros'],
    ['Abigarrado','abigarrado'],
    ['Albinos','albinos'],
    ['Arlequín','arlequín'],
    ['Atigrados ','atigrados'],
    ['Beige','beige'],
    ['Blanco','blanco'],
    ['Café','café'],
    ['Chocolate','Chocolate'],
    ['Multi color','multi color'],
    ['Monocromáticos','Monocromáticos'],
    ['Negro','negro'],
  ]

  GENDER = [
    ['Todos',nil],
    ['Otros','otros'],
    ['Hembra','hembra'],
    ['Macho','macho']
  ]

  def self.breeds
    breeds_response = RestClient.get("https://dog.ceo/api/breeds/list/all")
    breeds_hash = JSON.parse(breeds_response)['message']
    breeds = breeds_hash.keys
    breeds_option = breeds.map do |breed|
      [breed.capitalize, breed]
    end
    return [
      ['Todos',nil],
      ['Mestizo','mestizo'],
      ['Otros','otros'],
    ].concat breeds_option
  end
end

# BREEDS = [
  #   ['Todos',nil],
  #   ['Pitbull','pitbull'],
  #   ['Shiba inu','shiba inu'],
  #   ['Schnauzer','schnauzer'],
  #   ['Pastor aleman','pastor aleman'],
  #   ['Husky siberiano','husky siberiano'],
  #   ['Dogo','dogo'],
  #   ['Mestizo','mestizo'],
  #   ['Pitbull terrier','pitbull terrier'],
  #   ['Beagle','beagle'],
  #   ['Bulldog','bulldog'],
  #   ['Otros','otros'],
  # ]
