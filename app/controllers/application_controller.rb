class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :load_cate
  before_action :load_product_new
  before_action :load_product_hot
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_account!
  alias_method  :current_user, :current_account

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def load_cate
    @categories = Category.select_categories_parent.select_desc_parent
  end

  def load_product_new
    @product_news = Product.select_products.show_product_desc
    .limit Settings.size.count_new
  end

  def load_product_hot
    @product_hot = Product.select_products.show_product_hot_desc
    .limit Settings.size.count_hot
  end

  private

  def current_order
    if session[:order_id].present?
      @order = Order.find_by id: session[:order_id]
      return if @order.present?
      flash[:danger] = t "current_order_not_found"
      redirect_to root_path
    else
      Order.new
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: [:fullname, :phone, :address]
  end
end
