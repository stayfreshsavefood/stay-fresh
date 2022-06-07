class ExpiryNotificationsController < ApplicationController
  before_action :set_ingredients_to_expire, only: [:index]
  before_action :fridges_expiring_products, only: [:index]

  def index
    raise
  end

  def show

  end

  private

  def set_ingredients_to_expire
    @ingredients_to_expire = Ingredient.all.select do |ingredient|
      ingredient.how_long >= 0 && ingredient.how_long <= 2
    end
  end

  def fridges_expiring_products
    @your_fridges = FridgeUser.where(user: current_user.id)

    # gives you the instances of Fridge Users that have expiring products
    @ingredients_notifications = @your_fridges.all.select do |fridge|
      fridge_ingredients = Ingredient.where(fridge: fridge.fridge.id)
      ingredients_expiring = fridge_ingredients.all.select do |ingredient|
        ingredient.how_long >= 0 && ingredient.how_long <= 2
      end
      ingredients_expiring.length.positive?
    end

    # return the instances of the fridges that are in ingredients notifications
    @return_this_fridges = Fridge.all.select do |fridge|
      @fridges_expiring = @ingredients_notifications.each do |fridge_expiring|
        (fridge.id == fridge_expiring.fridge.id)
      end
    end
  end
end

#you already have the fridges_ids that need to be shown, the problem is that
