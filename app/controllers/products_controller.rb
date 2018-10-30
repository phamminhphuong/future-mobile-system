class ProductsController < ApplicationController
  def show
    @products = Product.show_product(params[:id])
      .page(params[:page])
      .per Settings.size.size_page
    @details = Product.show_detail(params[:id])
  end
end
