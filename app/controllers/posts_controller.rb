class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @marker = { lat: @post.latitude, lng: @post.longitude }
  end

  def new
    @post = Post.new
    @pet = Pet.find(params[:pet_id])
  end

  def create
    @post = Post.new(post_params)
    @pet = Pet.find(params[:pet_id])
    @post.pet = @pet
    @post.user = current_user
    if @post.save
      redirect_to pet_post_path(@pet, @post)
    else
      render "new"
    end
  end

  def locate

  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :address, :status,  photos: [])
  end
end
