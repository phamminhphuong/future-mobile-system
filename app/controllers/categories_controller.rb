class CategoriesController < ApplicationController
  def show
    @products = Product.show_product(params[:id])
      .page(params[:page])
      .per Settings.size.size_page
    @product_count = @products.size
    @order_detail = current_order.order_details.new
  end
end
