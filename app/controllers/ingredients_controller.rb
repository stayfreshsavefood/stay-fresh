class IngredientsController < ApplicationController

  def new
    @ingredients = Ingredient.new
  end

  def destroy
    @ingredients = Ingredient.find(params[:id])
    @ingredient.destroy
  end
end

def create
  @ingredient = Ingredient.new(ingredient_params)
  @ingredient.user = current_user
  if @ingredient.save
    redirect_to experiences_path, notice: 'Ingredient was successfully added.'
  else
    render :new
  end
end

private

def ingredient_params
  params.require(:ingredient).permit(:name, :exp_date, :category, :quantity, :comment, :fridge_id, :unit)
end
