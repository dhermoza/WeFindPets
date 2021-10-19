class ChatroomsController < ApplicationController
  def index
    @chatroom = Chatroom.all
  end
  def show 
    @post = Post.find(params[:id])
    @chatroom = Chatroom.find(params[:id])
    if !@chatroom
      @pet_report = Pet.where("id = #{@post.user_id}")
      @chatroom = Chatroom.create(name: "#{current_user.name} y #{@pet_report.name}")
     
    else
    end
    # @message = Message.new
    # @post = Post.find(params[:id])
    @message = Message.new
  end
end
