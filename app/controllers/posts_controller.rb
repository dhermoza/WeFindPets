class PostsController < ApplicationController
  helper_method :build_post_path
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    if params[:query].present?
      query = "address @@ :query OR title @@ :query"
      @flats = policy_scope(Flat).where("user_id = #{user_id}").geocoded
      @posts = Post.where(query, query: "%#{params[:query]}%").order("id ASC")
    else
      @posts = Post.all.order("id ASC")
    end
    @markers = @posts.geocoded.map do |post|
      {
        lat: post.latitude,
        lng: post.longitude,
        info_window: render_to_string(partial: "info_window", locals: { post: post })
      }
    end
  end

  def show
    @post = Post.find(params[:id])
    authorize @post
    @marker = { lat: @post.latitude, lng: @post.longitude }
  end

  def edit
    @post = Post.find(params[:id])
    @pet = @post.pet
    authorize @post
  end

  def new
    @post = Post.new
    @pet = Pet.find(params[:pet_id])
    authorize @post
  end

  def create
    @post = Post.new(post_params)
    @pet = Pet.find(params[:pet_id])
    @post.pet = @pet
    @post.user = current_user
    authorize @post
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
    authorize @post
    if @post.update(post_params)
      flash[:success] = "Se actualizó correctamente"
      redirect_to  posts_path
    else
      flash[:alert] = "Ingrese datos correctos"
      # redirect_to post_edit_path(@post)
      redirect_to edit_post_path(@post)
    end
  end

  def destroy
    @post = Post.find(params[:id])
    # authorize @flat
    @post.destroy
    flash[:success] = "Se elimino correctamente"
    redirect_to posts_path
  end


  #def build_post_path(post)
    #@is_my_post_path ?  post_edit_path(post) : post_path(post)
  #end



  def myposts
    user_id = current_user.id
    @posts = policy_scope(Post).where("user_id = #{user_id}")
    # redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :address, :status,  photos: [])
  end
end
