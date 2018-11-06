class OrderDetailsController < ApplicationController
  def new; end

  def create
    @order_new = OrderCreateService.new session: session, order_detail: params[:order_detail]
    @order_new.new_order
    render inline: Settings.reload_page
  end

  def destroy
    session[:cart].delete params[:id]
    flash[:success] = t "delete_success"
    redirect_to root_path
  end
end
