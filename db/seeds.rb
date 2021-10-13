# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
<<<<<<< HEAD
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

pet = Pet.new(user_id: 1, name:"lolo", size: "mediano", gender:"male", age:"2", color:"marron", breed:"pastor", animal:"perro" )
pet.save
post = Post.new(user_id: 1, pet_id: pet.id, title:"mascota perdida", description:"perdido en callao", status: "perdido", address: "mercado")
puts post.errors.full_messages.to_sentence
puts post.save
=======
# Examples:
>>>>>>> master
