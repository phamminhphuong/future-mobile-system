class CategoriesController < ApplicationController
  def show
    @products = Product.show_product(params[:id])
      .page(params[:page])
      .per Settings.size.size_page
  end
end
