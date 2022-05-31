class FridgesController < ApplicationController
  def show
    @fridges = Fridge.all
  end

  def new
    @fridge = Fridge.new
  end
end
