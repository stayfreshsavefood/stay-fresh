class IngredientsController < ApplicationController
  before_action :set_fridge, only: [:new, :create,:destroy]
  before_action :set_ingredient, only: [:edit,:update,:destroy]

  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    @ingredient.fridge = @fridge
    @ingredient.save
    if @ingredient.save
      redirect_to root_path, notice: 'Ingredient was successfully added.'
    else
     #add something here
    end
  end

  def destroy
    @ingredient.destroy
    redirect_to root_path
  end

  def edit
  end

  def update
    @ingredient.update(ingredient_params)
    redirect_to root_path
  end

  private

  def set_fridge
    @fridge = Fridge.find(params[:fridge_id])
  end

  def ingredient_params
    params.require(:ingredient).permit(:name, :exp_date, :category, :quantity, :comment, :unit)
  end

  def set_ingredient
    @ingredient = Ingredient.find(params[:id])
  end
end
