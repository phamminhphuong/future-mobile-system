class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :load_cate
  before_action :load_product_new
  before_action :load_product_hot

  def load_cate
    @categories = Category.select_category.create_desc.limit Settings.size.limit
  end

  def load_product_new
    @product_news = Product.select_products.show_product_desc
    .limit Settings.size.count_new
  end

  def load_product_hot
    @product_hot = Product.select_products.show_product_hot_desc
    .limit Settings.size.count_hot
  end
end
