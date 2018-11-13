class CartsController < ApplicationController
  def show
    if session[:cart].present?
      @products = Product.find_product(session[:cart].keys)
        .page(params[:page])
        .per Settings.size.size_page_order
      show_total_price_view
    else
      flash[:danger] = t "no_item"
      redirect_to root_path
    end
  end

  private

  def show_total_price_view
    @total = Settings.order.total
    products = Product.find_product session[:cart].keys
    products.each do |product|
      @total = @total + session[:cart][product.id.to_s] * product.price
    end
  end
end
