class FridgesController < ApplicationController
  before_action :set_invite_notifications, only: [:index, :show]

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
end
