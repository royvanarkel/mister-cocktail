class DosesController < ApplicationController
  def new
    @dose = Dose.new
    find_cocktails
    @ingredients = Ingredient.all
    @avialable_ingredients = find_avialable_ingredients(@ingredients, @cocktail)
  end

  def create
    find_cocktails
    @dose = Dose.new(dose_params)
    @dose.cocktail = @cocktail
    if @dose.valid?
      @dose.save
      redirect_to cocktail_path(@cocktail)
    else
      @ingredients = Ingredient.all
      @avialable_ingredients = find_avialable_ingredients(@ingredients, @cocktail)
      render :new
    end
  end

  def destroy
    @dose = Dose.find(params[:id])
    @cocktail = @dose.cocktail
    @dose.destroy!
    redirect_to cocktail_path(@cocktail)
  end


  private

  def dose_params
    params.require(:dose).permit(:description, :ingredient_id)
  end

  def find_cocktails
    @cocktail = Cocktail.find(params[:cocktail_id])
  end

  def find_avialable_ingredients(ingredients, cocktail)
    selected_ingr = ingredients.select do |ingredient|
      ingr = cocktail.ingredients
      !ingr.include?(ingredient)
    end
    return selected_ingr
  end

end
