class MessagesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @message = Message.new(message_params)
    @message.user = current_user
    @message.post = @post
    @message.save
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to post_path @post
  end

  private
    def message_params
      params.require(:message).permit(:user_id, :description, :post_id, :user, :post)
    end
end
