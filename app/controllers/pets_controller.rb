class PetsController < ApplicationController
  def index
    @pets = Pet.all
  end

  def new
    @pet = Pet.new
  end

  def create
    @pet = Pet.new(pet_params)
    @pet.user = current_user
    if @pet.save
      redirect_to new_pet_post_path(@pet)
    else
      render "new"
    end
  end

  private

  def pet_params
    params.require(:pet).permit(:name, :gender, :age, :size, :color, :breed, :animal)
  end
end
