class StaticPagesController < ApplicationController
  def home
    @products = Product.select_products
      .page(params[:page])
      .per Settings.size.size_page
    @details = Product.show_detail(params[:id])
  end

  def about; end
end
