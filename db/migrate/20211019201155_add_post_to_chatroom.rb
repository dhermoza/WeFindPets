class AddPostToChatroom < ActiveRecord::Migration[6.0]
  def change
    add_reference :chatrooms, :post, null: false, foreign_key: true
  end
end
