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
  @ingredient = Ingredient.new(experience_params)
  @ingredient.user = current_user
  if @experience.save
    redirect_to experiences_path, notice: 'Experience was successfully created.'
  else
    render :new
  end
end
