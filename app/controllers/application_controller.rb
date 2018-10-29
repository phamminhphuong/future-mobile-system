class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :load_cate

  def load_cate
    @categories = Category.select_category.create_desc.limit Settings.size.limit
  end
end
