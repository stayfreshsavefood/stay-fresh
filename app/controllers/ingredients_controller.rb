class IngredientsController < ApplicationController

  def index
    @ingredients = Ingredient.all
  end

  def new
    @ingredients = Ingredient.new
  end

  def destroy
    @ingredients = Ingredient.find(params[:id])
    @ingredient.destroy
  end
end
