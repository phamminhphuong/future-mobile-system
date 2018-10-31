class ProductsController < ApplicationController
  before_action :set_product, only: %i(show)

  def show
    @products = Product.show_product(params[:id]).includes(:manufacturers)
      .page(params[:page])
      .per Settings.size.size_page
    @details = Product.show_detail(params[:id])
      .page(params[:page])
      .per Settings.size.size_page
    @comments = Comment.where(product_id: @product).show_comment_desc
      .page(params[:page])
      .per Settings.size.picture_size
  end

  private

  def set_product
    @product = Product.find_by id: params[:id]
    return unless @product.nil?
    flash[:danger] = t "product_not_found"
    redirect_to root_path
  end

end
