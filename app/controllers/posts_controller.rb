class PostsController < ApplicationController

  def index
    @posts = Post.all.order("id ASC")

  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
    @pet = @post.pet
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

  def update
    @post = Post.find(params[:id])
    @pet = Pet.find(params[:pet_id])
    if @post.update(post_params)
      flash[:success] = "Se actualizó correctamente"
      redirect_to  posts_path
    else
      flash[:alert] = "Ingrese datos correctos"
    end
  end

  #def build_post_path(post)
    #@is_my_post_path ?  post_edit_path(post) : post_path(post)
  #end


  private

  def post_params
    params.require(:post).permit(:title, :description, :address, :status,  photos: [])
  end
end
