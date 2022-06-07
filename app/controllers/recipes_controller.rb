class RecipesController < ApplicationController
  def index
    require "json"
    require "open-uri"
    @fridge = Fridge.find(params[:fridge_id])
    @ingredients = @fridge.ingredients
    # url = "https://api.spoonacular.com/recipes/findByIngredients?ingredients=apples,+flour,+sugar&number=2&apiKey=babc8ab6d2624b198c4adbd7021e0043"
    @recipes = ingredients_api_call(@ingredients)
  end

  def show
    raise
  end

  private

  def ingredients_api_call(ingredients)
    base_url = "https://api.spoonacular.com/recipes/findByIngredients?"
    api_key = "&apiKey=#{ENV['API_KEY']}"
    temp_string = "ingredients="

    ingredients.each_with_index do |ingredient, index|
      if index == 0
        temp_string << ingredient.name
      else
        temp_string << ",+#{ingredient.name}"
      end
    end

    url = base_url + temp_string + api_key
    recipes_serialized = URI.open(url).read
    recipes = JSON.parse(recipes_serialized)
  end
end
