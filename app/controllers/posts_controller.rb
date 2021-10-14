class PostsController < ApplicationController

  def index
    if params[:query].present?
      query = "address @@ :query OR title @@ :query"
      @posts = Post.where(query, query: "%#{params[:query]}%").order("id ASC")
    else
      @posts = Post.all.order("id ASC")
    end
  end

  def show
    @post = Post.find(params[:id])
    @marker = { lat: @post.latitude, lng: @post.longitude }
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


  def myposts
    @is_my_posts = params[:myposts] == '1'
    if @is_my_posts
      user_id = current_user.id
      # @posts = policy_scope(Post).where("user_id = #{user_id}")
      redirect_to posts_path
    else
      @post = Post.all
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :address, :status,  photos: [])
  end
end
