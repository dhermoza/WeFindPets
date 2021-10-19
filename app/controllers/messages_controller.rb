class MessagesController < ApplicationController
  def index
    @messages = Message.all
  end

  def create
    @post = Post.find(params[:chatroom_id])
    @chatroom = Chatroom.find(params[:chatroom_id])
    @message = Message.new(message_params)
    @message.user = current_user
    @message.post = @post
    @message.chatroom = @chatroom

    if @message.save
      ChatroomChannel.broadcast_to(
        @chatroom,
        render_to_string(partial: "message", locals: { message: @message })
      )
      redirect_to chatroom_path(@chatroom, anchor: "message-#{@message.id}")
    else
      render "chatrooms/show"
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to post_path @post
  end

  private
    def message_params
      params.require(:message).permit(:user_id, :description, :post_id, :user)
    end
end
