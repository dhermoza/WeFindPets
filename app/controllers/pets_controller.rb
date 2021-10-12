class PetsController < ApplicationController
  def index
    @pets = Pets.all
  end
end
