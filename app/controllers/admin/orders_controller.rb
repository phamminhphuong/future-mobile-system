class Admin::OrdersController < Admin::BaseController
  before_action :load_order, only: %i(show)

  def index
    @orders = Order.select_order
  end

  def new; end

  def show
    @order_details = @order.order_details.select_order_detail
  end

  def edit; end

  private

  def load_order
    @order = Order.find_by id: params[:id]
    return if @order.present?
    flash[:danger] = t "not_order"
    redirect_to admin_orders_url
  end
end
