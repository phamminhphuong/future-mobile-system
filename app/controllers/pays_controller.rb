class PaysController < ApplicationController
  before_action :load_product, only: %i(create)
  before_action :authenticate_account

  def show
    @order = Order.new
    @order_details = {}
    products = Product.find session[:cart].keys
    products.each do |product|
      @order_details[product] = session[:cart][product.id.to_s]
    end
  end

  def create
    @order = Order.new order_params
    @order1 = OrderCreateService.new session: session, product: @product, order: @order
    if @order.save
      @order1.create_order
      @order_details = OrderDetail.select_order_detail_by_order @order
      get_total
      AccountMailer.send_email_order(current_account, @order_details, @price_total).deliver
      redirect_to root_path
      flash[:success] = t "order_success"
    else
      flash[:danger] = t "error"
      redirect_to root_path
    end
  end

  private

  def order_params
    params.require(:order).permit(:address, :phone).merge(status: Settings.size.status, account_id: current_account.id)
  end

  def load_product
    session[:cart].each do |product_id|
      @product = Product.find_by id: product_id
      return if @product.present?
      flash[:danger] = t "product_not_found"
      redirect_to root_path
    end
  end

  def authenticate_account
    return if current_account.present?
    flash[:danger] = t "sign_up_not_found"
    redirect_to login_url
  end

  def get_total
    @price_total = 0
    @order_details.each do |ord|
      @price_total += ord.total_price
    end
  end
end
