class ChatroomChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    # suscriber: execution when the client subcribe to a channel for notifications 
    chatroom = Chatroom.find(params[:id])

    # passing chatroomn instance
    stream_for chatroom
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
