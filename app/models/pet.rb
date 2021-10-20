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

  ANIMAL = [
    ['Todos',nil],
    ['Otros','otros'],
    ['Perro','perro'],
    ['Gato','gato']
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

  def self.other_breeds
    [
      ['Todos',nil],
      ['Mestizo','mestizo'],
    ]
  end

  def self.breed_cats
    breeds_response = RestClient.get("https://api.thecatapi.com/v1/breeds")
    breeds = JSON.parse(breeds_response)
    breeds_option = breeds.map do |breed_hash|
      breed = breed_hash['name']
      [breed.capitalize, breed]
    end
    return [
      ['Todos',nil],
      ['Mestizo','mestizo'],
      ['Otros','otros'],
    ].concat breeds_option
  end
end
