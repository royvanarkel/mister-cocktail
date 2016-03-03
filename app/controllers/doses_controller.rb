class DosesController < ApplicationController
  def new
    @dose = Dose.new
    find_cocktails
    @ingredients = Ingredient.all
    @avialable_ingredients = @ingredients.select do |ingredient|
      ingr = @cocktail.ingredients
      !ingr.include?(ingredient)
    end
  end

  def create
    find_cocktails
    @dose = Dose.new(dose_params)
    @dose.cocktail = @cocktail
    if @dose.save
      redirect_to cocktail_path(@cocktail)
    else
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

end
