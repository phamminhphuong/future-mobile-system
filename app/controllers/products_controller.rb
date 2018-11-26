class ProductsController < ApplicationController
  before_action :set_product, only: %i(show)
  before_action :set_price, only: %i(price)

  def show
    @comment = Comment.new
    @detail = Product.show_detail(params[:id])
    @product_likes = Product.where(category_id: @detail.category_id).where.not(id: @detail.id)
    @images = Image.select_image_product(@product).limit Settings.size.list_image
    @comments = Comment.select_comment_product(@product).show_comment_desc
      .page(params[:page])
      .per Settings.size.picture_size
    @order_detail  = current_order.order_details.new
  end

  def price
    @products_price = Product.show_product_price(@price_begin, @price_end).page(params[:page])
      .per Settings.size.size_page
    @order_detail  = current_order.order_details.new
  end

  private

  def set_product
    @product = Product.find_by id: params[:id]
    return unless @product.nil?
    flash[:danger] = t "product_not_found"
    redirect_to root_path
  end

  def set_price
    @price_begin = Settings.size.price_begin
    @price_end = Settings.size.price_end
    case params[:value]
    when Settings.value_price.one
      @price_begin = Settings.size.price_begin
      @price_end = Settings.size.price_end_one
    when Settings.value_price.two
      @price_begin = Settings.size.price_begin_two
      @price_end = Settings.size.price_end_two
    when Settings.value_price.three
      @price_begin = Settings.size.price_begin_three
      @price_end = Settings.size.price_end_three
    when Settings.value_price.four
      @price_begin = Settings.size.price_begin_four
      @price_end = Settings.size.price_end_four
    when Settings.value_price.five
      @price_begin = Settings.size.price_begin_five
      @price_end = Settings.size.price_end_file
    else
      flash[:danger] = t "bad_selection"
    end
  end
end
