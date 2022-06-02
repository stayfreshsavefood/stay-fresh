class IngredientsController < ApplicationController
  before_action :set_fridge, only: [:new, :create, :edit]
  before_action :set_ingredient, only: [:edit, :update, :destroy]

  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    @ingredient.fridge = @fridge
    @ingredient.save
    if @ingredient.save
      redirect_to fridge_path(@fridge), notice: 'Ingredient was successfully added.'
    else
     render :new
    end
  end

  def index

  end

  def destroy
    @ingredient.destroy
    redirect_to fridge_path(@ingredient.fridge), status: :see_other
  end

  def edit
  end

  def update
    if @ingredient.update(ingredient_params)
      redirect_to fridge_path(@ingredient.fridge)
    else
      render :edit
    end
  end

  private

  def fridge_params
    params.require(:fridge).permit(:name)
  end

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
