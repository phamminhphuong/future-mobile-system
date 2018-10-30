class StaticPagesController < ApplicationController
  def home
    @products = Product.select_products
      .page(params[:page])
      .per Settings.size.size_page
    @product_count = @products.size
  end

  def about; end

  def search
    @products = Product.search params[:search]
    @product_search = @products.size
  end
end
