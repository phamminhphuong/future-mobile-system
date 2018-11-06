class CardsController < ApplicationController
  def show
    @order_details = {}
    if session[:cart].present?
      products = Product.find session[:cart].keys
      products.each do |product|
        @order_details[product] = session[:cart][product.id.to_s]
      end
    else
      flash[:danger] = t "no_item"
      redirect_to root_path
    end
  end
end
