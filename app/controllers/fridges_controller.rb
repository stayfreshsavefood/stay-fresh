class FridgesController < ApplicationController
  def index
    @fridges = current_user.fridges
  end

  def show
    if !current_user.fridges.empty?
      @fridge = Fridge.find(params[:id])
    else
      @fridge = Fridge.new
    end
    if params[:query].present?
      @ingredients = @fridge.ingredients.search_by_name(params[:query])
    else
      @ingredients = @fridge.ingredients
    end
  end

  def create
    @fridge = Fridge.new(fridge_params)
    if @fridge.save
      @fridge_user = FridgeUser.new(user: current_user, fridge: @fridge)
      @fridge_user.save
      redirect_to fridges_path, notice: 'Fridge was successfully created.'
    else
      render :show
    end
  end

  def update
    @fridge = Fridge.find(params[:id])
    @fridge.update(fridge_params)
    redirect_to fridge_path(@fridge)
  end

  def destroy
    @fridge = Fridge.find(params[:id])
    @fridge.destroy
    redirect_to fridges_path, status: :see_other
  end
end
