class CategoriesController < ApplicationController
  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      redirect_to posts_path, flash: { 'alert-success' => "Your category has been created. OH GOOD FOR YOU!" }
    else
     flash.now[:'alert-danger'] = @category.errors.full_messages
     render :new
    end
  end

  private

   def find_category
     @category = Category.find params[:id]
   end

   def category_params
     params.require(:category).permit(:name, :title, :description, :sidebar, :submission_text)
   end

end
