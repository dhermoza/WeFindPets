class PostsController < ApplicationController
  helper_method :build_post_path
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    if params[:query].present?
      query = " \
        posts.address @@ :query \
        OR posts.title @@ :query \
        OR pets.breed @@ :query \
        OR pets.size @@ :query \
        OR pets.gender @@ :query \
        OR pets.color @@ :query \
        OR pets.animal @@ :query \
      "
      @posts = Post.joins(:pet).where(query, query: "%#{params[:query]}%").order("id ASC")
    elsif params[:breed].present?
      sql_query = "pets.breed ILIKE :query"
      @posts = Post.joins(:pet).where(sql_query, query: params[:breed])
    elsif params[:size].present?
      sql_query = "pets.size ILIKE :query"
      @posts = Post.joins(:pet).where(sql_query, query: params[:size])
    elsif params[:color].present?
      sql_query = "pets.color ILIKE :query"
      @posts = Post.joins(:pet).where(sql_query, query: params[:color])
    elsif params[:gender].present?
      sql_query = "pets.gender ILIKE :query"
      @posts = Post.joins(:pet).where(sql_query, query: params[:gender])
    elsif params[:animal].present?
      sql_query = "pets.animal ILIKE :query"
      puts "no lo borren por favor"
      @posts = Post.joins(:pet).where(sql_query, query: params[:animal])
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
    @message = Message.new
    @message.user = current_user
    authorize @post
    @marker = { lat: @post.latitude, lng: @post.longitude }
  end

  def edit
    @post = Post.find(params[:id])
    @pet = @post.pet
    authorize @post
    @marker = { lat: @post.latitude, lng: @post.longitude }
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
      flash['success'] = 'Se cre?? la publicaci??n con ??xito'
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
      flash[:success] = "Se actualiz?? correctamente"
      redirect_to  my_posts_path
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
    redirect_to my_posts_path
  end


  #def build_post_path(post)
    #@is_my_post_path ?  post_edit_path(post) : post_path(post)
  #end



  def myposts
    user_id = current_user.id
    @posts = policy_scope(Post).where("user_id = #{user_id}")
    @markers = @posts.geocoded.map do |post|
      {
        lat: post.latitude,
        lng: post.longitude,
        info_window: render_to_string(partial: "info_window", locals: { post: post })
      }
    end
    # redirect_to posts_path
  end

  def lost
    @posts = Post.where("status ILIKE ?", "Perdido").order("id ASC")
    @markers = @posts.geocoded.map do |post|
      {
        lat: post.latitude,
        lng: post.longitude,
        info_window: render_to_string(partial: "info_window", locals: { post: post })
      }
    end
  end

  def found
    @posts = Post.where("status ILIKE ?", "Encontrado").order("id ASC")
    @markers = @posts.geocoded.map do |post|
      {
        lat: post.latitude,
        lng: post.longitude,
        info_window: render_to_string(partial: "info_window", locals: { post: post })
      }
    end
  end



  private

  def post_params
    params.require(:post).permit(:title, :description, :address, :status,  photos: [])
  end
end
