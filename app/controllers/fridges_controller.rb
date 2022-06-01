class FridgesController < ApplicationController
  def show
    if current_user.fridges
      @fridge = Fridge.find(current_user.fridges[0].id)
    else
      @fridge = Fridge.new
    end
  end
end
