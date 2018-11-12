class PaysController < ApplicationController
  before_action :load_product, only: %i(create)
  before_action :authenticate_account

  def show
    @order = Order.new
    if session[:cart].present?
      @products = Product.find_product(session[:cart].keys)
      .page(params[:page])
      .per Settings.size.size_page_order
    else
      flash[:danger] = t "no_item"
      redirect_to root_path
    end
    show_total_price_view
  end

  def create
    @order = Order.new order_params
    orders = OrderCreateService.new session: session, order: @order
    if @order.save
      orders.create_order
      session[:cart] = nil
      @order_details = OrderDetail.select_order_detail_by_order @order
      get_total
      SendEmailJob.set(wait: Settings.time.time_send_email.seconds).perform_later(
        account: current_account,
        order: @order,
        total: @price_total)
      redirect_to root_path
      flash[:success] = t "order_success"
    else
      flash[:danger] = t "error"
      redirect_to root_path
    end
  end

  private

  def order_params
    @order_details = {}
    products = Product.find session[:cart].keys
    products.each do |product|
      @order_details[product] = session[:cart][product.id.to_s]
    end
    total_price
    params.require(:order).permit(:address, :phone).merge(status: Settings.size.status, account_id: current_account.id, total: @total)
  end

  def load_product
    @products = Product.find_product session[:cart].keys.map(&:to_i)
    return if @products.present?
      flash[:danger] = t "product_not_found"
      redirect_to root_path
  end

  def authenticate_account
    return if current_account.present?
    flash[:danger] = t "sign_up_not_found"
    redirect_to new_account_session_path
  end

  def get_total
    @price_total = Settings.size.price_total_start
    @order_details.each do |ord|
      @price_total += ord.total_price
    end
  end

  def total_price
    @total = Settings.order.total
    @order_details.each do |product, quantity|
      quantity * product.price
      @total = @total + (quantity * product.price)
    end
  end

  def show_total_price_view
    @total = Settings.order.total
    products = Product.find_product session[:cart].keys
    products.each do |product|
      @total = @total + session[:cart][product.id.to_s] * product.price
    end
  end
end
