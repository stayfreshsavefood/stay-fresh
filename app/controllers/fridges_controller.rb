require 'date'
class FridgesController < ApplicationController
  before_action :set_invite_notifications, only: [:index, :show]
  before_action :set_ingredients_to_expire, only: [:show]
  before_action :set_expiry_notifications, only: [:show]
  before_action :set_fridges_expiring_products, only: [:index]

  def index
    @fridges = current_user.fridges
    @fridge = Fridge.new()
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

    if params[:sort] == "category"
      @ingredients = @ingredients.sort_by(&:category)
    else
      @ingredients = @ingredients.sort_by(&:exp_date)
    end
  end

  def create
    @fridge = Fridge.new(fridge_params)
    if @fridge.save!
      @fridge_user = FridgeUser.new(user: current_user, fridge: @fridge)
      @fridge_user.save
      redirect_to root_path, notice: 'Fridge was successfully created.'
    else
      render :index, status: :unprocessable_entity
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
  private

  def fridge_params
    params.require(:fridge).permit(:name)
  end

  def set_invite_notifications
    @invite_notifications = InviteNotification.where(receiver_user_id: current_user.id, status: false)
  end

  def set_ingredients_to_expire
    @fridge = Fridge.find(params[:id])
    @ingredients_to_expire = Ingredient.where(fridge: @fridge.id).select do |ingredient|
      ingredient.how_long >= 0 && ingredient.how_long <= 2
    end
  end

  def set_expiry_notifications
    @fridge = Fridge.find(params[:id])
    @expiry_notifications = ExpiryNotification.where(fridge_id: @fridge).select do |notification|
      notification.how_long >= 0 && notification.how_long <= 2
    end
  end

  def set_fridges_expiring_products
    @your_fridges = FridgeUser.where(user: current_user.id)

    # gives you the instances of Fridge Users that have expiring products
    @fridges_notifications = @your_fridges.all.select do |fridge|
      fridge_ingredients = Ingredient.where(fridge: fridge.fridge.id)
      ingredients_expiring = fridge_ingredients.all.select do |ingredient|
        ingredient.how_long >= 0 && ingredient.how_long <= 2
      end
      ingredients_expiring.length.positive?
    end
  end
end
