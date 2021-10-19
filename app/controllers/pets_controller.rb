class PetsController < ApplicationController
  def index
    @pets = Pet.all
    if params[:breed].present?
      @pets = Pet.where(breed: params[:breed])
    end
    if params[:size].present?
      puts "here2"
      @pets = Pet.where(size: params[:size])
    end
    if params[:color].present?
      puts "here2"
      @pets = Pet.where(color: params[:color])
    end

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

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    @pet = Pet.find(params[:id])
    if @pet.update(pet_params)
      flash['success'] = 'Se actualizó con éxito'
      redirect_to my_posts_path
    else
      redirect_to edit_post_path(@post)
    end
  end

  private

  def pet_params
    params.require(:pet).permit(:name, :gender, :age, :size, :color, :breed, :animal, photos: [])
  end
end
