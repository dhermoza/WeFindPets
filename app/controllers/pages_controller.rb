class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @last_founds = Post.where( status: "Encontrado").order('created_at desc').last(3).map do |post|
      post.pet
    end
    @last_losts = Post.where( status: "Perdido").order('created_at desc').last(3).map do |post|
      post.pet
    end
  end
end
