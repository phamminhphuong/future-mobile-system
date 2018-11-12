class StaticPagesController < ApplicationController
  def home
    @products = Product.select_products
      .page(params[:page])
      .per Settings.size.size_page
    @product_count = @products.size
    @order_detail = current_order.order_details.new
  end

  def about; end

  def search
    @products = @search.result.page(params[:page])
      .per Settings.size.size_page
    @product_search = @products.size
  end

  def contact; end

  def introduct; end
end
