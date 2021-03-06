class ChatroomsController < ApplicationController
  def index
    @chatrooms = Chatroom.all.select{ |chat| chat.user.id == current_user.id || chat.post.user.id == current_user.id}
    @chatroom = Chatroom.find(@chatrooms.first.id)
    if @chatroom.user == current_user || @chatroom.post.user == current_user
      @message = Message.new
    else
      redirect_to post_path(@chatroom.post), notice: "No existe"
    end
   
  end

  def show 
    @chatrooms = Chatroom.all.select{ |chat| chat.user.id == current_user.id || chat.post.user.id == current_user.id}
    @chatroom = Chatroom.find(params[:id])
    if @chatroom.user == current_user || @chatroom.post.user == current_user
      @message = Message.new
    else
      redirect_to post_path(@chatroom.post), notice: "No existe"
    end
   
  end
  
  def create
    @post = Post.find(params[:post_id])
    @chatroom = Chatroom.find_by(user: current_user, post: @post)
    if !@chatroom
      @chatroom = Chatroom.create(name: "#{current_user.name} y #{@post.user.name}", user: current_user, post: @post)
    end
    redirect_to chatroom_path(@chatroom)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @chatroom = Chatroom.find(params[:id])
    @chatroom.destroy
    redirect_to chatrooms_path @chatroom
  end
end
